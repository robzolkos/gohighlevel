# frozen_string_literal: true

# Shared Minitest contract every Storage backend must satisfy.
#
# Tests including this module must define a `setup` that assigns
# `@storage` to a freshly-initialized backend with a client_id already set.
module SessionStorageContract
  def test_round_trips_a_session
    @storage.set_session("res-1", access_token: "tok-1", refresh_token: "ref-1", expires_in: 3600)

    session = @storage.get_session("res-1")

    assert_equal "tok-1", session[:access_token]
    assert_equal "ref-1", session[:refresh_token]
  end

  def test_set_session_stamps_expire_at
    before = (Time.now.to_f * 1000).to_i
    @storage.set_session("res-1", access_token: "tok-1", expires_in: 60)
    after = (Time.now.to_f * 1000).to_i

    expire_at = @storage.get_session("res-1")[:expire_at]

    assert_operator expire_at, :>=, before + (60 * 1000)
    assert_operator expire_at, :<=, after + (60 * 1000) + 1000
  end

  def test_set_session_strips_internal_timestamps_on_read
    @storage.set_session("res-1", access_token: "tok-1")
    session = @storage.get_session("res-1")

    refute_includes session.keys, :created_at
    refute_includes session.keys, :updated_at
  end

  def test_get_session_returns_nil_when_missing
    assert_nil @storage.get_session("missing")
  end

  def test_get_access_token_returns_just_the_token
    @storage.set_session("res-1", access_token: "tok-1")
    assert_equal "tok-1", @storage.get_access_token("res-1")
  end

  def test_get_access_token_is_nil_when_session_missing
    assert_nil @storage.get_access_token("missing")
  end

  def test_delete_session_removes_it
    @storage.set_session("res-1", access_token: "tok-1")
    @storage.delete_session("res-1")

    assert_nil @storage.get_session("res-1")
  end

  def test_delete_session_on_missing_key_is_a_noop
    @storage.delete_session("missing")
  end

  def test_init_is_idempotent
    @storage.init
    @storage.init
  end

  def test_disconnect_clears_sessions
    @storage.set_session("res-1", access_token: "tok-1")
    @storage.disconnect

    assert_nil @storage.get_session("res-1")
  end

  def test_set_client_id_rejects_empty_values
    assert_raises(ArgumentError) { @storage.set_client_id("") }
    assert_raises(ArgumentError) { @storage.set_client_id(nil) }
  end

  def test_concurrent_writes_are_safe
    threads = 50.times.map do |i|
      Thread.new { @storage.set_session("res-#{i}", access_token: "tok-#{i}") }
    end
    threads.each(&:join)

    50.times do |i|
      assert_equal "tok-#{i}", @storage.get_access_token("res-#{i}")
    end
  end
end

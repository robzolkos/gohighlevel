# frozen_string_literal: true

require "test_helper"

module HighLevel
  # Regression: when a host app (typically Rails in CI/production) calls
  # `Zeitwerk::Loader.eager_load_all`, the gem's loader must not crash.
  # Two classes of files used to break it:
  #
  #   1. Optional storage backends top-level-require gems that aren't
  #      runtime deps (active_record, mongo, redis). Missing optional
  #      gem → LoadError.
  #   2. Generated model files define acronym-style constants
  #      (e.g. AdCampaignDTO) that don't match Zeitwerk's default
  #      inflection (AdCampaignDto) → Zeitwerk::NameError.
  #
  # `lib/high_level.rb` excludes both from eager loading. They remain
  # autoloadable on demand.
  class ZeitwerkEagerLoadTest < Minitest::Test
    GEM_LIB = File.expand_path("../../lib", __dir__)

    def setup
      @loader = nil
      Zeitwerk::Registry.loaders.each { |l| @loader = l if l.tag == "gohighlevel" }
      refute_nil @loader, "expected to find the gohighlevel Zeitwerk loader"
    end

    def test_mongo_is_not_available_in_this_test_process
      # Sanity check: if `mongo` were installed in the test bundle, this
      # regression test couldn't reproduce the original LoadError.
      assert_raises(LoadError) { require "mongo" }
    end

    def test_eager_load_does_not_crash_when_optional_gems_are_missing
      @loader.eager_load
    end

    def test_optional_storage_backends_are_excluded_from_eager_load
      %w[active_record.rb mongo.rb redis.rb].each do |file|
        path = File.join(GEM_LIB, "high_level/storage", file)
        assert @loader.__send__(:excluded_from_eager_load?, path),
               "#{file} should be excluded from eager_load"
      end
    end

    def test_generated_models_directory_is_excluded_from_eager_load
      path = File.join(GEM_LIB, "high_level/models")
      assert @loader.__send__(:excluded_from_eager_load?, path),
             "lib/high_level/models should be excluded from eager_load"
    end

    def test_storage_backends_are_still_autoloadable_on_demand
      # do_not_eager_load only affects bulk eager loading — the
      # constants must still resolve through normal autoload.
      require "active_record"
      assert HighLevel::Storage::ActiveRecord
    end
  end
end

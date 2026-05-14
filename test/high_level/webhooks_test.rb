# frozen_string_literal: true

require "test_helper"
require "openssl"
require "base64"

module HighLevel
  class WebhooksTest < Minitest::Test
    PAYLOAD = '{"type":"INSTALL","companyId":"co-1","locationId":"loc-1"}'
    TAMPERED = '{"type":"INSTALL","companyId":"co-1","locationId":"loc-evil"}'

    def setup
      @rsa = OpenSSL::PKey::RSA.generate(2048)
      @rsa_signature = Base64.strict_encode64(@rsa.sign(OpenSSL::Digest.new("SHA256"), PAYLOAD))
      @rsa_public_pem = @rsa.public_key.to_pem

      @ed = OpenSSL::PKey.generate_key("ED25519")
      @ed_signature = Base64.strict_encode64(@ed.sign(nil, PAYLOAD))
      @ed_public_pem = @ed.public_to_pem
    end

    def test_valid_rsa_signature_returns_true
      assert_equal true, Webhooks.verify(
        payload: PAYLOAD,
        signature: @rsa_signature,
        public_key: @rsa_public_pem,
        scheme: :rsa
      )
    end

    def test_rsa_is_the_default_scheme
      assert_equal true, Webhooks.verify(
        payload: PAYLOAD,
        signature: @rsa_signature,
        public_key: @rsa_public_pem
      )
    end

    def test_tampered_body_raises_for_rsa
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: TAMPERED,
          signature: @rsa_signature,
          public_key: @rsa_public_pem,
          scheme: :rsa
        )
      end
    end

    def test_wrong_rsa_public_key_raises
      other_rsa = OpenSSL::PKey::RSA.generate(2048).public_key.to_pem
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: PAYLOAD,
          signature: @rsa_signature,
          public_key: other_rsa,
          scheme: :rsa
        )
      end
    end

    def test_valid_ed25519_signature_returns_true
      assert_equal true, Webhooks.verify(
        payload: PAYLOAD,
        signature: @ed_signature,
        public_key: @ed_public_pem,
        scheme: :ed25519
      )
    end

    def test_tampered_body_raises_for_ed25519
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: TAMPERED,
          signature: @ed_signature,
          public_key: @ed_public_pem,
          scheme: :ed25519
        )
      end
    end

    def test_wrong_ed25519_public_key_raises
      other_ed = OpenSSL::PKey.generate_key("ED25519").public_to_pem
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: PAYLOAD,
          signature: @ed_signature,
          public_key: other_ed,
          scheme: :ed25519
        )
      end
    end

    def test_missing_signature_raises
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(payload: PAYLOAD, signature: nil, public_key: @rsa_public_pem)
      end

      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(payload: PAYLOAD, signature: "", public_key: @rsa_public_pem)
      end
    end

    def test_missing_public_key_raises
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(payload: PAYLOAD, signature: @rsa_signature, public_key: nil)
      end
    end

    def test_malformed_base64_signature_raises
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: PAYLOAD,
          signature: "not-base64-!!!",
          public_key: @rsa_public_pem,
          scheme: :rsa
        )
      end
    end

    def test_malformed_public_key_raises
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: PAYLOAD,
          signature: @rsa_signature,
          public_key: "not a PEM",
          scheme: :rsa
        )
      end
    end

    def test_unknown_scheme_raises_argument_error
      assert_raises(ArgumentError) do
        Webhooks.verify(
          payload: PAYLOAD,
          signature: @rsa_signature,
          public_key: @rsa_public_pem,
          scheme: :hmac
        )
      end
    end

    def test_scheme_mismatch_rsa_signature_with_ed25519_key_raises
      assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: PAYLOAD,
          signature: @rsa_signature,
          public_key: @ed_public_pem,
          scheme: :ed25519
        )
      end
    end

    def test_rsa_scheme_against_ed25519_key_wraps_openssl_error
      # The :rsa path calls verify with a SHA256 digest; an Ed25519 key
      # rejects digests outright and OpenSSL raises. We wrap that as
      # InvalidSignatureError rather than letting OpenSSL::OpenSSLError leak.
      error = assert_raises(Webhooks::InvalidSignatureError) do
        Webhooks.verify(
          payload: PAYLOAD,
          signature: @rsa_signature,
          public_key: @ed_public_pem,
          scheme: :rsa
        )
      end
      assert_includes error.message, "openssl error"
    end
  end
end

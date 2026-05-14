# frozen_string_literal: true

require "base64"
require "openssl"

module HighLevel
  # Verifies inbound HighLevel webhook signatures.
  #
  # HighLevel signs webhook payloads with the platform's *private* key and
  # publishes the corresponding *public* key. Verification is therefore
  # asymmetric — the `public_key:` argument is the published PEM key, not
  # a shared secret.
  #
  # Two schemes are supported:
  #   :rsa     — RSA-SHA256. Signature arrives on `x-wh-signature`.
  #   :ed25519 — Ed25519.    Signature arrives on `x-ghl-signature`.
  #
  # Both signatures are base64-encoded. The payload is the raw JSON body
  # of the request as bytes — do not re-serialize via your framework's
  # parser (round-tripping changes the canonical form).
  #
  # Source: vendor/highlevel-api-sdk/lib/webhook/webhook-manager.ts
  # (verifySignature + verifyEd25519Signature) cross-checked with the
  # published HighLevel webhook docs.
  module Webhooks
    # The supported signature schemes.
    SCHEMES = %i[rsa ed25519].freeze

    # Raised by {Webhooks.verify} when a payload fails verification for
    # any reason — bad signature, wrong key, malformed input.
    class InvalidSignatureError < HighLevel::Error; end

    # Verify a webhook signature. Returns true on success; raises
    # InvalidSignatureError on any failure mode (bad signature, wrong key,
    # malformed base64, missing inputs). Caller-supplied ArgumentError for
    # invalid scheme.
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def self.verify(payload:, signature:, public_key:, scheme: :rsa)
      raise ArgumentError, "scheme must be one of: #{SCHEMES.join(", ")}" unless SCHEMES.include?(scheme)
      raise InvalidSignatureError, "signature is required" if signature.nil? || signature.to_s.empty?
      raise InvalidSignatureError, "public_key is required" if public_key.nil? || public_key.to_s.empty?

      signature_bytes = decode_signature(signature)
      key = load_key(public_key)
      valid = verify_for(scheme, key, signature_bytes, payload.to_s)
      raise InvalidSignatureError, "signature does not match payload" unless valid

      true
    rescue OpenSSL::OpenSSLError => e
      raise InvalidSignatureError, "openssl error: #{e.message}"
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity

    def self.decode_signature(signature)
      Base64.strict_decode64(signature)
    rescue ArgumentError
      raise InvalidSignatureError, "signature is not valid base64"
    end
    private_class_method :decode_signature

    def self.load_key(public_key)
      OpenSSL::PKey.read(public_key)
    rescue OpenSSL::PKey::PKeyError => e
      raise InvalidSignatureError, "invalid public key: #{e.message}"
    end
    private_class_method :load_key

    def self.verify_for(scheme, key, signature_bytes, payload)
      case scheme
      when :rsa     then key.verify(OpenSSL::Digest.new("SHA256"), signature_bytes, payload)
      when :ed25519 then key.verify(nil, signature_bytes, payload)
      end
    end
    private_class_method :verify_for
  end
end

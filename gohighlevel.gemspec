# frozen_string_literal: true

require_relative "lib/high_level/version"

Gem::Specification.new do |spec|
  spec.name = "gohighlevel"
  spec.version = HighLevel::VERSION
  spec.authors = ["Rob Zolkos"]
  spec.email = ["rob@zolkos.com"]

  spec.summary = "Ruby SDK for the HighLevel (GoHighLevel) API."
  spec.description = "A Ruby SDK for the HighLevel (GoHighLevel) API, generated from the " \
                     "official OpenAPI spec with runtime behavior validated against the " \
                     "official TypeScript SDK."
  spec.homepage = "https://github.com/rzolkos/gohighlevel"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["lib/**/*.rb"] + %w[LICENSE.txt CHANGELOG.md gohighlevel.gemspec]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "faraday-multipart", "~> 1.0"
  spec.add_dependency "zeitwerk", "~> 2.6"
end

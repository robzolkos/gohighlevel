# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development, :test do
  gem "minitest", "~> 5.20"
  gem "rake", "~> 13.0"
  gem "rubocop", "~> 1.60"
  gem "simplecov", "~> 0.22", require: false
  gem "webmock", "~> 3.20"
  gem "yard", "~> 0.9"

  # Storage backends — runtime-optional for users; required here so the
  # backend contract tests exercise each one.
  gem "activerecord", "~> 8.0"
  gem "redis", "~> 5.0"
  gem "sqlite3", "~> 2.0"
end

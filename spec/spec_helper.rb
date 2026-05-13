# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end

require "gohighlevel"
require "webmock/rspec"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = false
  config.order = :random
  Kernel.srand config.seed
end

WebMock.disable_net_connect!(allow_localhost: true)

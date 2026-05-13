# frozen_string_literal: true

require "zeitwerk"

module HighLevel
end

loader = Zeitwerk::Loader.new
loader.tag = "gohighlevel"
loader.push_dir("#{__dir__}/high_level", namespace: HighLevel)
loader.setup

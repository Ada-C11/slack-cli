require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "vcr"
require "dotenv"
Dotenv.load

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes"
  config.hook_into :webmock
end

require "./lib/recipient.rb"
require "./specs/recipient_spec.rb"
# require "users_spec.rb"
# require "channels_spec.rb"

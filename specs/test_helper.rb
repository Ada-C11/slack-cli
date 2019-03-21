require "simplecov"
SimpleCov.start

require "httparty"
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "vcr"
require "pry"
require "dotenv"
Dotenv.load

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<SLACK_API_TOKEN>") do
    ENV["SLACK_API_TOKEN"]
  end
end

require_relative "../lib/recipient.rb"
require_relative "./recipient_spec.rb"
# require "users_spec.rb"
# require "channels_spec.rb"

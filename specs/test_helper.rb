require "simplecov"
SimpleCov.start

require "minitest/skip_dsl"
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
  config.cassette_library_dir = "specs/cassettes" # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    record: :new_episodes, # record new data when we don't have it yet
    match_requests_on: %i[method uri body] # The http method, URI and body of a request all need to match
  }
  # Don't leave our token lying around in a cassette file.
  config.filter_sensitive_data("<SLACK_API_TOKEN>") do
    ENV["SLACK_API_TOKEN"]
  end
end

require_relative "../lib/recipient.rb"
require_relative "./recipient_spec.rb"
require "./lib/user.rb"
require "./specs/user_specs.rb"
require "./lib/channel.rb"
require "./specs/channel_spec.rb"

# require "channels_spec.rb"

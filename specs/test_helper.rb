require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'

require_relative "../lib/user.rb"
require_relative "../lib/channel.rb"
require_relative "../lib/workspace.rb"
require_relative "../lib/recipient.rb"
require_relative "../lib/slack.rb"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,    # record new data when we don't have it yet
    match_requests_on: [:method, :uri, :body] # The http method, URI and body of a request all need to match
  }
  # Don't leave our Slack token lying around in a cassette file.
  config.filter_sensitive_data("<TOKEN>") do
    ENV["TOKEN"]
  end
end
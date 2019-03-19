require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "webmock/minitest"
require "minitest/skip_dsl"
require "vcr"
require "dotenv"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

Dotenv.load

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes" # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }
  # Don't leave our Slack token lying around in a cassette file.
  config.filter_sensitive_data("<SLACK_TOKEN>") do
    ENV["SLACK_TOKEN"]
  end
end

require_relative "../lib/user"
require_relative "../lib/channel"
require_relative "../lib/workspace"
require_relative "../lib/recipient"

# What would you like to test
# test for 200 status and message - different
# length of members
# id
# raise error if channel or user doesn't exist

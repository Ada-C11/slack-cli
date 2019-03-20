require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "vcr"
require "webmock/minitest"
require "dotenv"
require "httparty"
require "awesome_print"

Dotenv.load

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/channel"
require_relative "../lib/user"
require_relative "../lib/recipient"
require_relative "../lib/workspace"
# require_relative "../lib/slack" # Do we need this? Don't think so.

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes" # folder where casettes will be
  config.hook_into :webmock # tie into this other rool called webmock
  config.default_cassette_options = {
    :record => :new_episodes, # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body],
  }
  # Don't leave our token lying around in cassette file.
  config.filter_sensitive_data("<SLACK_API_TOKEN>") do
    ENV["SLACK_API_TOKEN"]
  end
end

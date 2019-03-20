require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "webmock/minitest"
require "vcr"
require "dotenv"

Dotenv.load

require_relative "../lib/recipient.rb"
require_relative "../lib/user.rb"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }

  config.filter_sensitive_data("<SLACK_API_KEY>") do
    ENV["SLACK_API_KEY"]
  end
end

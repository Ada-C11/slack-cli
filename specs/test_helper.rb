require "simplecov"
SimpleCov.start do
  add_filter %r{^/specs?/}
end

require "dotenv"
Dotenv.load

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "webmock/minitest"
require "vcr"

require_relative "../lib/channel"
require_relative "../lib/user"
require_relative "../lib/workspace"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:method, :uri, :body],
  }
  config.filter_sensitive_data("SLACK_API_TOKEN") do
    ENV["SLACK_API_TOKEN"]
  end
end

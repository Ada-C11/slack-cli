require "simplecov"
SimpleCov.start do
  add_filter %r{^/specs?/}
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "vcr"

require_relative "../lib/slack"
require_relative "../lib/channel"
require_relative "../lib/user"
require_relative "../lib/workspace"
# require_relative "../lib/recipient"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }
  config.filter_sensitive_data("<SLACK_TOKEN>") do
    ENV["SLACK_TOKEN"]
  end
end

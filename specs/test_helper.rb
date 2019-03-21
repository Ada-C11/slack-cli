require "simplecov"
SimpleCov.start do
  add_filter %r{^/spec/}
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "webmock/minitest"
require "vcr"
require "dotenv"
require "table_print"
Dotenv.load

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/recipient"
require_relative "../lib/user"
require_relative "../lib/slack"
require_relative "../lib/channels"
require_relative "../lib/workspace"

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes" # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }
  # Don't leave our token lying around in a cassette file.
  config.filter_sensitive_data("<SLACK_TOKEN>") do
    ENV["KEY"]
  end
end

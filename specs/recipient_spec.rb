require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/recipient.rb"
require_relative "../lib/slack_main.rb"

describe "Recipient class" do
  before do
    VCR.use_cassette("recipient_get") do
      query_params = { token: ENV["SLACK_API_TOKEN"] }
      @response = Slack::Recipient.get("https://slack.com/api/users.list", query_params)
    end
  end

  it "can retrieve a list of users" do
    expect(@response).must_be_kind_of HTTParty::Response
    expect(@response["members"]).must_be_kind_of Array
    expect(@response["members"].length).must_be_kind_of Integer
  end
end

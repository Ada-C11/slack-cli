require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/recipient.rb"

describe "Recipient class" do
  before do
    VCR.use_cassette("recipient_get") do
      BASE_URL = "https://slack.com/api/users.list"
      @query_params = { token: ENV["SLACK_API_TOKEN"] }

      @response = HTTParty.get(BASE_URL, query: @query_params)
    end
  end

  it "creates an instance of Recipient" do
    slack_id = @response["members"][1]["id"]
    name = @response["members"][1]["name"]

    recipient = Slack::Recipient.new(slack_id: slack_id, name: name)

    expect(recipient).must_be_kind_of Slack::Recipient
  end
end

require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/recipient.rb"
require_relative "../lib/slack_main.rb"


describe "Recipient class" do
  before do
    VCR.use_cassette("recipient_get") do
      @response = get_recipient("user")
    end
  end

  it "creates an instance of Recipient" do
    slack_id = @response["members"][1]["id"]
    name = @response["members"][1]["name"]

    recipient = Slack::Recipient.new(slack_id: slack_id, name: name)

    expect(recipient).must_be_kind_of Slack::Recipient
  end
end

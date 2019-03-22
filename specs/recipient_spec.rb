require_relative "test_helper.rb"
require "pry"

describe "Recipient class" do
  it "creates an instance of Recipient class" do
    receiver = Slack::Recipient.new("id", "name")
    expect(receiver).must_be_instance_of Slack::Recipient
  end
end

describe "Post message method" do
  it "will return a true value for 'ok'" do
    VCR.use_cassette("message_find") do
      recipient_id = "USLACKBOT"
      name = "slackbot"

      message = "Hi Slackbot! - Heather and Mina"

      new_message = Slack::Recipient.new(recipient_id, name).post_message(message)
      expect(new_message["ok"]).must_equal true
      expect(new_message["message"]["text"]).must_match "- Heather and Mina"
    end
  end
end

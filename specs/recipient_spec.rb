require "test_helper.rb"

describe "Recipient class" do
  it "creates an instance of Recipient class" do
    receiver = Slack::Recipient.new("slack_id", "name")
    expect(receiver).must_be_instance_of Slack::Recipient
  end
end

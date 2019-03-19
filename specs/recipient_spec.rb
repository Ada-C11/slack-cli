require "test_helper.rb"

describe "Recipient class" do
  it "creates an instance of Recipient class" do
    receiver = Slack::Recipient
    expect(receiver).must_be_instance_of Slack::Recipient
  end
end

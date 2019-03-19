require 'test_helper.rb'

describe "Recipient class" do
  describe "initialize" do
    expect(Slack::Recipient.new(name: "test", id: "abc")).must_be_instance_of Slack::Recipient
  end
end
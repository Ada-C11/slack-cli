require_relative "test_helper"

describe "Recipient" do
  describe "self.list" do
    it "Raises NotImplementedError if called directly on recipient" do
      expect {
        SlackBot::Recipient.list
      }.must_raise NotImplementedError
    end
  end

  describe "details" do
    it "Raise NotImplementedError if called directory on recipient" do
      recipient = SlackBot::Recipient.new
      expect {
        recipient.details
      }.must_raise NotImplementedError
    end
  end
end

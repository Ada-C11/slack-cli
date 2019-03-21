require_relative "test_helper"

describe "Recipient Class" do
  describe "self.list" do
    it "raises an Error if invoked directly (without subclassing)" do
      expect {
        Slack::Recipient.list
      }.must_raise NotImplementedError
    end
  end
end

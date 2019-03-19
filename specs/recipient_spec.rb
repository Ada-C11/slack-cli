require_relative "test_helper"

describe "recipient class" do
  describe "initialize" do
    it "creates an instance of Recipient" do
      slack_id = 1
      name = "Maria"
      expect(Recipient.new(slack_id: slack_id, name: name)).must_be_kind_of Recipient
    end
  end
end

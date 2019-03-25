require_relative "test_helper"

describe "Recipient Class" do
  describe "self list method" do
    it "raises an error if not implemented in a subclass" do
      expect { Slack::Recipient.list }.must_raise NotImplementedError
    end
  end

  describe "send message method" do
    it "raises error if parameters are incorrect" do
    end
  end
end

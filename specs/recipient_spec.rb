require_relative "test_helper"

describe "Recipient" do
  let(:slack_id) { 20 }
  let(:username) { "Sopheary" }
  let(:recipient) { Slack::Recipient.new(slack_id, username) }

  describe "Initialization" do
    it "can be instantiated" do
      expect(recipient).must_be_instance_of Slack::Recipient
      expect(recipient.slack_id).must_equal 20
      expect(recipient.name).must_equal "Sopheary"
    end
  end

  describe "send message" do
  end

  describe "self.get" do
    it "can get valid user data from the API" do
      VCR.use_cassette("recipient") do
        url = "https://slack.com/api/users.list"

        return_value = Slack::Recipient.get(url)
        expect(return_value["ok"]).must_equal true
      end
    end

    it "can get valid channel data from the API" do
      VCR.use_cassette("recipient") do
        url = "https://slack.com/api/channels.list"
        return_value = Slack::Recipient.get(url)
        expect(return_value["ok"]).must_equal true
      end
    end
  end

  describe "self.list" do
    it "raises error if attempted" do
      expect { Slack::Recipient.list }.must_raise NotImplementedError
    end
  end

  describe "details" do
    it "raises error if attempted" do
      expect { recipient.details }.must_raise NotImplementedError
    end
  end
end

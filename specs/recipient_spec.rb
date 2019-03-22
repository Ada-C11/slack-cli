require_relative "test_helper"

describe "Recipient" do
  describe "self.get method" do
    before do
      @url = "https://slack.com/api/channels.list"
    end
    it "successfully returns a response" do
      VCR.use_cassette("get_data") do
        query_params = {
          token: KEY,
        }
        response = Slack::Recipient.get(@url, query: query_params)
        expect(response["ok"]).must_equal true
      end
    end

    it "will raise an exception with incorrect token" do
      VCR.use_cassette("get_data") do
        query_params = {
          token: "U R A TOKEN",
        }
        expect {
          Slack::Recipient.get(@url, query: query_params)
        }.must_raise Slack::SlackApiError
      end
    end

    it "will raise an exception with invalid url" do
      VCR.use_cassette("get_data") do
        query_params = {
          token: KEY,
        }
        expect {
          Slack::Recipient.get("abcdefg", query: query_params)
        }.must_raise Addressable::URI::InvalidURIError
      end
    end
  end

  describe "self.list" do
    it "returns a notImplementedError" do
      expect {
        Slack::Recipient.list
      }.must_raise NotImplementedError
    end
  end

  describe "details" do
    it "returns a notImplementedError" do
      recipient = Slack::Recipient.new(slack_id: 123, name: "hi")
      expect {
        recipient.details
      }.must_raise NotImplementedError
    end
  end

  describe "send_message" do
    before do
      VCR.use_cassette("send_message") do
        query_params = {
          token: KEY,
        }
        url = "https://slack.com/api/channels.list"
        response = Slack::Recipient.get(url, query: query_params)
        slack_id = response["channels"].first["id"]
        name = response["channels"].first["name"]
        @recipient = Slack::Recipient.new(slack_id: slack_id, name: name)
      end
    end

    it "successfully sends a message" do
      VCR.use_cassette("send_message") do
        message = @recipient.send_message("HELLO WORLD!")
        expect(message["ok"]).must_equal true
      end
    end
  end
end

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
end

# name is correct

# request is successful

# raise error if there is bad url

# raise error if api token is not authenticated

# error invoked if not called in subclass

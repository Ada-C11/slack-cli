require_relative "test_helper"
# slack id is correctly extracted

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

    it "will raise an exception if the search fails" do
      VCR.use_cassette("more_data") do
        query_params = {
          token: "U R A TOKEN",
        }
        expect {
          Slack::Recipient.get(@url, query: query_params)
        }.must_raise Slack::SlackApiError
      end
    end
  end
end

# name is correct

# request is successful

# raise error if there is bad url

# raise error if api token is not authenticated

# error invoked if not called in subclass

require_relative "test_helper"
describe "p" do
  it "~" do
    VCR.use_cassette("slacker") do
      slack = Slack.new
      query_parameters = {
        token: ENV["SLACK_API_TOKEN"],
      }
      url = "https://slack.com/api/conversations.list?"
      response = HTTParty.get(url, query: query_parameters)

      expect(slack.response["Channels"]).wont_be_nil
      # expect(response["Seattle"][:lon]).must_equal "-122.3300624"
      # expect(response["Seattle"][:lat]).must_equal "47.6038321"
    end
  end
end

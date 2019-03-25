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

      expect(slack.channels).wont_be_nil
    end
  end
end

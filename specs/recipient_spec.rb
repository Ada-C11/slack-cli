require_relative "test_helper"
USER_URL = "https://slack.com/api/users.list"
CHANNEL_URL = "https://slack.com/api/channel.list"

describe "Recipient Class" do
  before do
    @test = SlackCLI::Recipient.new("abc12whatever", "HiChris")
  end
  describe "Recipient initialization" do
    it "name returns as a string for user" do
      expect(@test.name).must_be_kind_of String
    end

    it "name returns correct string" do
      expect(@test.name).must_equal "HiChris"
    end

    it "id returns as a string for user" do
      expect(@test.id).must_be_kind_of String
    end

    it "id returns correct string" do
      expect(@test.id).must_equal "abc12whatever"
    end
  end

  describe "self.get method" do
    it "returns url and parameters as a concatenated string" do
      VCR.use_cassette("get_response") do
        user = USER_URL
        param = ENV["SLACK_API_TOKEN"]
        request_url = SlackCLI::Recipient.get_response(user, param)
        expect(request_url).must_be_kind_of HTTParty::Response
      end
    end
  end
end

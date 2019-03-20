require "test_helper"

describe "User Class" do
  describe "self.get" do
    it "sucessfully gets a response from Slack API for user list" do
      VCR.use_cassette("user_information_find") do
        url = "https://slack.com/api/users.list"
        query = {token: ENV["KEY"]}
        request = Slack::User.get(url, query)

        expect(request["ok"]).must_equal true
      end
    end

    it "will raise an exception if the GET request fails" do
      VCR.use_cassette("user_information_find") do
        url = "https://slack.com/api/users.list"
        query = {token: "dkdkdkdkdkdkd"}

        expect {
          Slack::User.get(url, query)
        }.must_raise Slack::Recipient::ResponseError
      end
    end

    # describe "self.list" do
    #   it "returns an array" do
    #     VCR.use_cassette("user_information_find") do

    #       Slack::User.list("https://slack.com/api/users.list", {token: ENV["KEY"]})
    #     end
    #   end

    # end
  end
end

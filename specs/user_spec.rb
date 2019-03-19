require "test_helper"

describe "User Class" do
  describe "self.get" do
    it "returns an array" do
      VCR.use_cassette("user_information_find") do
        URL = "https://slack.com/api/users.list"
        query = {token: ENV["KEY"]}
        expect(Slack::User.get(URL, query)).must_be_kind_of HTTParty::Response
        # expect(User.list(User.get(URL, query))).must_be_kind_of Array
      end
    end

    it "returns instances of Users" do
    end
  end
end

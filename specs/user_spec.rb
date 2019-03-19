require_relative "test_helper"

describe "User class" do
  describe "self.list" do
    it "can return all users" do
      VCR.use_cassette("slack_user") do
        response = User.get("user")

        expect(response["members"]).wont_be_nil
        expect(response["members"].first["name"]).must_equal "slackbot"
        expect(response["members"].first["id"]).must_equal "USLACKBOT"
      end
    end

    # it "raises an exception if response is invalid" do
    #   VCR.use_cassette("slack_user") do
    #     response = User.get("user")
    #     expect(response["ok"]).must_equal false
    #   end
    # end
  end
end

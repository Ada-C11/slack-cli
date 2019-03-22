require_relative "test_helper"
describe SlackAPI do
  describe "self.list" do
    it "list all users" do
      VCR.use_cassette("list_users") do
        response = SlackAPI::User.list_users
        expect(response).wont_be_nil
        expect(response[2]).must_equal "name" => "aribray", "real name" => "Ariana Bray",
          "slack id" => "UH3UT3SJK"
        expect(response.length).must_equal 3
      end
    end
    it "will raise an error if given an invalid key" do
      real_token = ENV["SLACK_API_TOKEN"]
      ENV["SLACK_API_TOKEN"] = "NOT_REAL_TOKEN"

      VCR.use_cassette("list_users_2") do
        error = expect {
          SlackAPI::User.list_users
        }.must_raise SlackAPI::SlackError
        expect(error.message).must_equal "There was an error. The error message is invalid_auth"
      end

      ENV["SLACK_API_TOKEN"] = real_token
    end
  end

  describe "send_usr_msg" do
    it "sends a message to selected user" do
      VCR.use_cassette("send_usr_msg") do
        msg = SlackAPI::User.new.send_msg("UH3UT3SJK", "This is a test message!")
        expect(msg).must_equal true
      end
    end

    it "generates an error if given an invalid user" do
      VCR.use_cassette("send_usr_msg") do
        expect {
          SlackAPI::User.new.send_msg("bob's your uncle", "Test message")
        }.must_raise SlackAPI::SlackError
      end
    end

    it "will raise an error if given an empty message" do
      VCR.use_cassette("send_usr_msg") do
        error = expect {
          SlackAPI::User.new.send_msg("UH3UT3SJK",
                                      "")
        }.must_raise SlackAPI::SlackError
      end
    end
  end
end

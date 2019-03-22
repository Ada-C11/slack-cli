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
    # it "raises error if response 'ok' is false" do
    #   real_token = ENV["SLACK_API_TOKEN"]
    #   ENV["SLACK_API_TOKEN"] = "badtoken"

    #   VCR.use_cassette("list_users") do
    #     return_value = SlackAPI::User.list_users
    #     expect (return_value).must_equal true
    #   end
    #   ENV["SLACK_API_TOKEN"] = real_token
    # end
  end

  describe "select_user" do
    it "selects a user as the current recipient when user inputs ID" do
      user = SlackAPI::User.new
      VCR.use_cassette("select_user") do
        response = user.select_user("UH3UT3SJK")
        expect(response).must_equal "UH3UT3SJK"
      end
    end
    it "selects a user as the current recipient when user inputs name" do
      user = SlackAPI::User.new
      VCR.use_cassette("select_user") do
        response = user.select_user("aribray")
        expect(response).must_equal "UH3UT3SJK"
      end
    end
    it "raises a SlackError if the user's name or id is invalid" do
      user = SlackAPI::User.new
      VCR.use_cassette("select_user") do
        expect { user.select_user("fakeuser") }.must_raise SlackAPI::SlackError
      end
    end
  end

  describe "see_details" do
    it "shows details for selected user" do
      user = SlackAPI::User.new
      VCR.use_cassette("select_user") do
        selected_user = user.select_user("UH3UT3SJK")
        user_details = user.see_details(selected_user)

        expect(user_details).must_be_kind_of Array
        expect(user_details.length).must_equal 1
        expect(user_details[0]).must_equal "name" => "aribray", "real name" => "Ariana Bray", "slack id" => "UH3UT3SJK"
      end
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

        # expect(error.message).must_equal "Error when posting  to ports-api-testing, error: no_text"
      end
    end
  end
end

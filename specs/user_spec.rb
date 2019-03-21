require_relative "test_helper"
describe SlackAPI do
  describe "self.list" do
    it "list all users" do
      VCR.use_cassette("list_users") do
        response = SlackAPI::User.list_users
        puts response
        expect(response).wont_be_nil
        expect(response.keys.include?("aribray")).must_equal true
        expect(response["aribray"]).must_equal "real name" => "Ariana Bray",
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
        expect(response).must_equal "aribray"
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

        expect(user_details).must_be_kind_of Hash
        expect(user_details.length).must_equal 1
        expect(user_details["aribray"]).must_equal "real name" => "Ariana Bray",
                                                   "slack id" => "UH3UT3SJK"
      end
    end
  end
end

require_relative "test_helper"

describe SlackApi::User do
  describe "json users" do
    it "returns valid users" do
      VCR.use_cassette("slack_users_json") do
        url = "https://slack.com/api/users.list"
        key = ENV["SLACK_API_TOKEN"]

        users_list = SlackApi::User.user_api(url, key)

        users_list.each do |user|
          expect(user["team_id"]).wont_be_nil
        end
      end
    end

    it "includes a specific username" do
      VCR.use_cassette("slack_user_list") do
        url = "https://slack.com/api/users.list"
        key = ENV["SLACK_API_TOKEN"]

        users_list = SlackApi::User.user_api(url, key)

        expect(users_list.first["name"]).must_equal "slackbot"
      end
    end

    it "includes a specific user's real name" do
      VCR.use_cassette("slack_user_list") do
        url = "https://slack.com/api/users.list"
        key = ENV["SLACK_API_TOKEN"]

        users_list = SlackApi::User.user_api(url, key)

        expect(users_list.first["real_name"]).must_equal "Slackbot"
      end
    end

    it "includes a specific user's slack id" do
      VCR.use_cassette("slack_user_list") do
        url = "https://slack.com/api/users.list"
        key = ENV["SLACK_API_TOKEN"]

        users_list = SlackApi::User.user_api(url, key)

        expect(users_list.first["id"]).must_equal "USLACKBOT"
      end
    end

    it "users list will only include existent users" do
      VCR.use_cassette("slack_users_json") do
        url = "https://slack.com/api/users.list"
        key = ENV["SLACK_API_TOKEN"]

        users_list = SlackApi::User.user_api(url, key)

        users_list.each do |user|
          name = "Not a User"
          expect(user["name"]).wont_equal name
        end
      end
    end

    it "raises error when a bad API call is made" do
      VCR.use_cassette("slack_users_list") do
        url = "https://slack.com/api/users.list"

        expect { SlackApi::User.user_api(url, "") }.must_raise SlackApi::SlackError
      end
    end
  end

  describe "list users" do
    it "returns an array" do
      VCR.use_cassette("slack_users_list") do
        url = "https://slack.com/api/users.list"
        key = ENV["SLACK_API_TOKEN"]

        users_list = SlackApi::User.user_api(url, key)
        expect(SlackApi::User.list(users_list)).must_be_instance_of Array
      end
    end
  end
end

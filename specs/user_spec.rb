require_relative "test_helper"

describe SlackApi::User do
  describe "json users" do
    it "returns valid users" do
      VCR.use_cassette("slack_users_json") do
        users_list = SlackApi::User.user_api

        users_list.each do |user|
          expect(user["team_id"]).wont_be_nil
        end
      end
    end

    it "includes a specific user" do
      VCR.use_cassette("slack_users_json") do
        users_list = SlackApi::User.user_api

        expect(users_list.first["name"]).must_equal "slackbot"
      end
    end

    it "users list will only include existent users" do
      VCR.use_cassette("slack_users_json") do
        users_list = SlackApi::User.user_api

        users_list.each do |user|
          name = "Not a User"
          expect(user["name"]).wont_equal name
        end
      end
    end
    # it "returns info with a valid token" do
    #   VCR.use_cassette("slack_channels_list") do
    #     channels_list = SlackApi::Channel.user_api

    #     expect(users_list["ok"]).must_equal true
    #   end
    # end
  end

  describe "list users" do
    it "contains slackbot as a user" do
      skip
      VCR.use_cassette("slack_users_list") do
        users_list = SlackApi::User.user_api
        # users_list.each do |user|

        # end
        expect(SlackApi::User.list(users_list)).must_include "slackbot"
      end
    end

    it "returns an array" do
      VCR.use_cassette("slack_users_list") do
        users_list = SlackApi::User.user_api
        expect(SlackApi::User.list(users_list)).must_be_instance_of Array
      end
    end
  end
end

# users:

#tests -->

#0. make sure that what's being returned is in the format we want (i.e. a hash or array)

#2. make sure that the right things are being returned for each users
# expect { one component of Amy's user info is } real name
# expect { one component of Amy's user info is } slack_id
# expect { one component of Amy's user info is } username

#3. expect if there are NO users -> return empty array

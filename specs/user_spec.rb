require_relative "test_helper"

describe "User" do
  describe "self.list" do
    before do
      VCR.use_cassette("make users list") do
        query_params = {
          token: KEY,
        }
        @users = Slack::User.list
        @user = @users.first
      end
    end

    it "will return an array of Users" do
      expect(@users).must_be_kind_of Array
      expect(@user).must_be_kind_of Slack::User
    end

    it "will assign the correct attributes to each user" do
      expect(@user.slack_id).must_equal "USLACKBOT"
      expect(@user.name).must_equal "slackbot"
      expect(@user.real_name).must_equal "Slackbot"
      expect(@user.status_text).must_equal ""
      expect(@user.status_emoji).must_equal ""
    end

    it "has the correct data tyes for each attribute" do
      expect(@user.slack_id).must_be_kind_of String
      expect(@user.name).must_be_kind_of String
      expect(@user.real_name).must_be_kind_of String
      expect(@user.status_text).must_be_kind_of String
      expect(@user.status_emoji).must_be_kind_of String
    end
  end

  describe "details" do
    before do
      VCR.use_cassette("show user details") do
        query_params = {
          token: KEY,
        }
        @users = Slack::User.list
        @user = @users.first
      end
    end

    it "returns the correct data" do
      details = @user.details
      expected_details = {
        slack_id: @user.slack_id,
        name: @user.name,
        real_name: @user.real_name,
        status_text: @user.status_text,
        status_emoji: @user.status_emoji,
      }

      expect(details).must_equal expected_details
    end
  end
end

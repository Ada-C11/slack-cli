require_relative "test_helper"

describe "User" do
  describe "Initialization" do
    let(:slack_id) { 20 }
    let(:username) { "soph" }
    let(:real_name) { "Sopheary" }
    let(:status_text) { "Good to go" }
    let(:status_emoji) { ":)" }

    it "can be instantiated" do
      user = Slack::User.new(slack_id, username, real_name, status_text, status_emoji)
      expect(user).must_be_instance_of Slack::User
      expect(user.slack_id).must_equal 20
      expect(user.name).must_equal "soph"
      expect(user.real_name).must_equal "Sopheary"
      expect(user.status_text).must_equal "Good to go"
      expect(user.status_emoji).must_equal ":)"
    end

    describe "List" do
      it "can list itself" do
        VCR.use_cassette("users_found") do
          response = Slack::User.list

          expect(response[0].name).must_equal "slackbot"
          expect(response[1].name).must_equal "sopheary.chiv"
        end
      end
    end
  end
end

require_relative "test_helper"
require "pry"
describe "show details method" do
  it "gives details for a specific instance of Channel" do
    VCR.use_cassette("slack_channels") do
      test_workspace = Workspace.new
      channel_test_1 = Channel.list[0][0]
      user_test_1 = User.list[0][0]

      expect(test_workspace.show_details(channel_test_1)).must_equal ["everyone", "Company-wide announcements and work-based matters", 2, "CH0E8S9UY"]
      expect(test_workspace.show_details(user_test_1)).must_equal ["slackbot", "Slackbot", "USLACKBOT"]
    end
  end

  it "raises SlackApiError if list is nil" do
    VCR.use_cassette("slack_channels") do
      User.list
      test_workspace = Workspace.new
      test_workspace.select_user("")
      test_workspace.select_channel("")

      expect { test_workspace.show_details(test_workspace.select_user("")) }.must_raise Workspace::SlackApiError
      expect { test_workspace.show_details(test_workspace.select_channel("")) }.must_raise Workspace::SlackApiError
    end
  end
end

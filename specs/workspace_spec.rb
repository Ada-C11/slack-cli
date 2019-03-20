require_relative "test_helper"
require "pry"
describe "show details method" do
  it "gives details for a specific instance of Channel" do
    VCR.use_cassette("slack_channels") do
      #   response = test_channel.get_channel
      Channel.list
      test_workspace = Workspace.new
      channel_test_1 = Channel.list[0][0]

      expect(test_workspace.show_details_channel(channel_test_1)).must_equal ["everyone", "Company-wide announcements and work-based matters", 2, "CH0E8S9UY"]
      # expect(Channel.list.first).must_be_kind_of Array
    end
  end

  it "gives details for a specific instance of User" do
    VCR.use_cassette("slack_channels") do
      #   response = test_channel.get_channel
      User.list
      test_workspace = Workspace.new
      user_test_1 = User.list[0][0]

      expect(test_workspace.show_details_user(user_test_1)).must_equal ["slackbot", "Slackbot", "USLACKBOT"]
    end
  end

  # edge cases, what if the list is 0?
  # argument error, this user/channel does not exist.
end

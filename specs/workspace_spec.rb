require_relative "test_helper"
require "pry"
describe "show details method" do
  it "gives details for a specific instance of Channel" do
    VCR.use_cassette("slack_channels") do
      #   response = test_channel.get_channel
      list_of_channels = Channel.list
      test_workspace = Workspace.new
      channel_test_1 = Channel.list[0][0]

      expect(test_workspace.show_details_channel(channel_test_1)).must_equal ["everyone", "Company-wide announcements and work-based matters", 2, "CH0E8S9UY"]
      # expect(Channel.list.first).must_be_kind_of Array
    end
  end
end

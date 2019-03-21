require_relative "test_helper"

describe "Workspace class" do
  before do
    VCR.use_cassette("slack_api") do
      @workspace = Slack::Workspace.new
    end
  end

  describe "Workspace#initialize" do
    it "returns a workspace object" do
      expect(@workspace).must_be_instance_of Slack::Workspace
    end

    it "responds to instance variable and selected is nil" do
      expect(@workspace).must_respond_to :channels
      expect(@workspace).must_respond_to :users
      expect(@workspace).must_respond_to :selected
      expect(@workspace.selected).must_be_nil
    end

    it "has correct instance variable types" do
      expect(@workspace.channels[1]).must_be_instance_of Slack::Channel
      expect(@workspace.users[1]).must_be_instance_of Slack::User
    end
  end

  describe "Workspace#Select_channel" do
    it "will set the selected variable to input channel" do
      @workspace.select_channel(channel: @workspace.channels[1])
      expect(@workspace.selected).must_equal @workspace.channels[1]
    end
  end
end

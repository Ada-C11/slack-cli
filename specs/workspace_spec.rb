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
    it "will set the selected variable to input channel and returns true" do
      expect(@workspace.select_channel(channel: @workspace.channels[1])).must_equal true
      expect(@workspace.selected).must_equal @workspace.channels[1]
    end
  end

  describe "Workspace#Select_user" do
    it "will set the selected variable to input user" do
      @workspace.select_user(user: @workspace.users[1])
      expect(@workspace.selected).must_equal @workspace.users[1]
    end
  end

  describe "Workspace#list_all" do
    it "will return a string" do
      expect(@workspace.list_all(list: @workspace.channels)).must_be_instance_of String
      expect(@workspace.list_all(list: @workspace.users)).must_be_instance_of String
    end

    it "will return the correct String format" do
      test_list = @workspace.list_all(list: @workspace.channels)
    end
  end
end

require_relative "test_helper"

describe "SlackCLI::Workspace" do
  before do
    VCR.use_cassette("workspace") do
      @workspace = SlackCLI::Workspace.new
    end
  end

  describe "constructor" do
    it "is an instance of Channel" do
      expect(@workspace).must_be_kind_of SlackCLI::Workspace
    end

    it "has a collection of users, collection of channels, and a selected recipient is nil" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users.first).must_be_kind_of SlackCLI::User
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels.first).must_be_kind_of SlackCLI::Channel
      expect(@workspace.selected).must_be_nil
    end
  end

  describe "select_user" do
    it "should return an instance of User, given valid name" do
      username = @workspace.users.first.name
      expect(@workspace.select_user(username)).must_be_kind_of SlackCLI::User
      expect(@workspace.selected).must_be_kind_of SlackCLI::User
      expect(@workspace.selected).must_equal @workspace.users.first
    end

    it "should return an instance of User, given valid slack id" do
      slack_id = @workspace.users.first.slack_id
      expect(@workspace.select_user(slack_id)).must_be_kind_of SlackCLI::User
      expect(@workspace.selected).must_be_kind_of SlackCLI::User
      expect(@workspace.selected).must_equal @workspace.users.first
    end

    it "should update selected when a new user is selected" do
      slack_id1 = @workspace.users.first.slack_id
      slack_id2 = @workspace.users.last.slack_id
      @workspace.select_user(slack_id1)
      expect(@workspace.selected).must_equal @workspace.users.first
      @workspace.select_user(slack_id2)
      if slack_id1 != slack_id2
        expect(@workspace.selected).must_equal @workspace.users.last
      end
    end

    it "should return nil, given invalid user" do
      bad_username = ""
      @workspace.select_user(bad_username)
      expect(@workspace.selected).must_be_nil
    end
  end

  describe "select_channel" do
    it "should return an instance of Channel, given valid name" do
      name = @workspace.channels.first.name
      expect(@workspace.select_channel(name)).must_be_kind_of SlackCLI::Channel
      expect(@workspace.selected).must_be_kind_of SlackCLI::Channel
      expect(@workspace.selected).must_equal @workspace.channels.first
    end

    it "should return an instance of Channel, given valid slack id" do
      slack_id = @workspace.channels.first.slack_id
      expect(@workspace.select_channel(slack_id)).must_be_kind_of SlackCLI::Channel
      expect(@workspace.selected).must_be_kind_of SlackCLI::Channel
      expect(@workspace.selected).must_equal @workspace.channels.first
    end

    it "should update selected when a new channel is selected" do
      slack_id1 = @workspace.channels.first.slack_id
      slack_id2 = @workspace.channels.last.slack_id
      @workspace.select_channel(slack_id1)
      expect(@workspace.selected).must_equal @workspace.channels.first
      @workspace.select_channel(slack_id2)
      if slack_id1 != slack_id2
        expect(@workspace.selected).must_equal @workspace.channels.last
      end
    end

    it "should update selected from user to channel when new channel is selected" do
      user_slack_id = @workspace.users.first.slack_id
      channel_slack_id = @workspace.channels.first.slack_id
      @workspace.select_user(user_slack_id)
      expect(@workspace.selected).must_equal @workspace.users.first
      @workspace.select_channel(channel_slack_id)
      expect(@workspace.selected).must_equal @workspace.channels.first
    end

    it "should return nil, given invalid channel" do
      bad_slack_id = ""
      @workspace.select_channel(bad_slack_id)
      expect(@workspace.selected).must_be_nil
    end
  end

  describe "show details" do
    it "displays details for user" do
      username = @workspace.users.first.name
      @workspace.select_user(username)
      user_detail = @workspace.show_details
      expect(user_detail).must_be_kind_of String
      expect(@workspace.users.first.details).must_equal user_detail
    end

    it "displays details for channel" do
      channel_name = @workspace.channel.first.name
      @workspace.select_channel(channel_name)
      channel_detail = @workspace.show_details
      expect(channel_detail).must_be_kind_of String
      expect(@workspace.channels.first.details).must_equal channel_detail
    end

    it "returns nil if selected is nil" do
      if @workspace.selected == nil
        expect(@workspace.details).must_be_nil
      end
    end
  end
end

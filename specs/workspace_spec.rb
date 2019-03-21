require_relative "test_helper"

describe "Workspace class" do
  describe "initialize method" do
    it "will return expected user info" do
      VCR.use_cassette("initialize workspace") do
        query_params = {
          token: KEY,
        }
        workspace = Slack::Workspace.new
        workspace_first_user = workspace.users[0]
        first_loaded_user = Slack::User.list.first

        expect(workspace).must_be_kind_of Slack::Workspace
        expect(workspace.users).must_be_kind_of Array
        expect(workspace_first_user).must_be_kind_of Slack::User
        expect(workspace.users.last).must_be_kind_of Slack::User
        expect(workspace_first_user.slack_id).must_equal first_loaded_user.slack_id
      end
    end

    it "will return expected channel info" do
      VCR.use_cassette("initialize workspace") do
        query_params = {
          token: KEY,
        }
        workspace = Slack::Workspace.new
        workspace_first_channel = workspace.channels[0]
        first_loaded_channel = Slack::Channel.list.first

        expect(workspace).must_be_kind_of Slack::Workspace
        expect(workspace.channels).must_be_kind_of Array
        expect(workspace_first_channel).must_be_kind_of Slack::Channel
        expect(workspace.channels.last).must_be_kind_of Slack::Channel
        expect(workspace_first_channel.slack_id).must_equal first_loaded_channel.slack_id
      end
    end
  end

  describe "select user method" do
    before do
      VCR.use_cassette("initialize workspace") do
        query_params = {
          token: KEY,
        }
        @workspace = Slack::Workspace.new
      end
    end

    it "will select a user based on user's name" do
      name = "evelynnkaplan"
      selected_user = @workspace.select_user(name)

      expect(selected_user).must_be_kind_of Slack::User
      expect(selected_user.name).must_equal name
    end

    it "will select a user based on user's id" do
      id = "UH0J2E2D6"
      selected_user = @workspace.select_user(id)

      expect(selected_user).must_be_kind_of Slack::User
      expect(selected_user.slack_id).must_equal id
    end

    it "returns nil if no user is found" do
      id = "cat"
      selected_user = @workspace.select_user(id)

      expect(selected_user).must_be_nil
    end
  end

  describe "select channel method" do
    before do
      VCR.use_cassette("initialize workspace") do
        query_params = {
          token: KEY,
        }
        @workspace = Slack::Workspace.new
      end
    end

    it "will select a channel based on channel's name" do
      name = "random"
      selected_channel = @workspace.select_channel(name)

      expect(selected_channel).must_be_kind_of Slack::Channel
      expect(selected_channel.name).must_equal name
    end

    it "will select a channel based on channel's id" do
      id = "CH4DKF32S"
      selected_channel = @workspace.select_channel(id)

      expect(selected_channel).must_be_kind_of Slack::Channel
      expect(selected_channel.slack_id).must_equal id
    end

    it "returns nil if no channel is found" do
      id = "dog"
      selected_channel = @workspace.select_channel(id)

      expect(selected_channel).must_be_nil
    end
  end

  describe "show details" do
    before do
      VCR.use_cassette("test details") do
        query_params = {
          token: KEY,
        }
        @workspace = Slack::Workspace.new
      end
    end

    it "details for selected recipient is string" do
      @workspace.select_user("evelynnkaplan")
      expect(@workspace.show_details).must_be_kind_of String
    end

    it "returns nil if no recipient" do
      expect(@workspace.show_details).must_be_nil
    end
  end
end

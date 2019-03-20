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
end

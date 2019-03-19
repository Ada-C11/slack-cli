require_relative "test_helper"

describe "Workspace object" do
  it "will initialize a new workspace object" do
    VCR.use_cassette("workspace") do
      new_workspace = SlackCLI::Workspace.new(
        users: SlackCLI::User.get_from_api,
        channels: SlackCLI::Channel.get_from_api,
      )
      expect(new_workspace).must_be_instance_of SlackCLI::Workspace
    end
  end
  it "will return an array of user info strings" do
    VCR.use_cassette("workspace") do
      new_workspace = SlackCLI::Workspace.new(
        users: SlackCLI::User.get_from_api,
        channels: SlackCLI::Channel.get_from_api,
      )
      expect(new_workspace.display_users).must_be_instance_of Array
      new_workspace.display_users.each do |user|
        expect(user).must_be_instance_of String
      end
    end

    it "will return an array of channel info strings" do
      VCR.use_cassette("workspace") do
        new_workspace = SlackCLI::Workspace.new(
          users: SlackCLI::User.get_from_api,
          channels: SlackCLI::Channel.get_from_api,
        )
        expect(new_workspace.display_channels).must_be_instance_of Array
        new_workspace.display_channels.each do |channel|
          expect(channel).must_be_instance_of String
        end
      end
    end
  end
end

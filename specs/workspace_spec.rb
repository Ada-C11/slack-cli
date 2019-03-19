require_relative "test_helper"

describe "Workspace object" do
  it "will initialize a new workspace object" do
    skip
    VCR.use_cassette("workspace") do
      new_workspace = SlackCLI::Workspace.new(
        users: SlackCLI::User.get_from_api,
        channels: SlackCLI::Channel.get_from_api,
      )
      expect(new_workspace).must_be_instance_of SlackCLI::Workspace
    end
  end
end

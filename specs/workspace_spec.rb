require_relative "test_helper"

describe "Workspace object" do
  before do
    VCR.use_cassette("workspace") do
      @new_workspace = SlackCLI::Workspace.new(
        users: SlackCLI::User.get_from_api,
        channels: SlackCLI::Channel.get_from_api,
      )
    end
  end

  it "will initialize a new workspace object" do
    expect(@new_workspace).must_be_instance_of SlackCLI::Workspace
  end

  it "selects a user by username" do
    name = users.first.username
    expect(select_user(name)).must_equal users.first
  end

  it "selects a user by id" do
    id = users.first.slack_id
    expect(select_user(id)).must_equal users.first
  end

  it "selects a channel by name" do
    channel = channels.first.channel_name
    expect(select_channel(channel)).must_equal channels.first
  end

  it "selects a channel by id" do
    id = channels.first.id
    expect(select_channel(id)).must_equal channels.first
  end 
end

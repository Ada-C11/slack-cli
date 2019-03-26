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
    user = @new_workspace.users.first
    name = @new_workspace.users.first.name
    expect(@new_workspace.select_user(name)).must_equal user
  end

  it "selects a user by id" do
    user = @new_workspace.users.first
    id = @new_workspace.users.first.slack_id
    expect(@new_workspace.select_user(id)).must_equal user
  end

  it "selects a channel by name" do
    channel = @new_workspace.channels.first
    name = @new_workspace.channels.first.name
    expect(@new_workspace.select_channel(name)).must_equal channel
  end

  it "selects a channel by id" do
    channel = @new_workspace.channels.first
    id = @new_workspace.channels.first.slack_id
    expect(@new_workspace.select_channel(id)).must_equal channel
  end

  it "can send a valid message with id to a channel" do
    VCR.use_cassette("post message") do
      id = @new_workspace.channels.first.slack_id
      @new_workspace.select_channel(id)
      response = @new_workspace.send_message("This is a test!")
      expect(response).must_equal true
    end
  end

  it "can send a valid message with id to a user" do
    VCR.use_cassette("post message") do
      id = @new_workspace.users.first.slack_id
      @new_workspace.select_user(id)
      response = @new_workspace.send_message("This is a test!")
      expect(response).must_equal true
    end
  end

  it "can send a valid message with name to a channel" do
    VCR.use_cassette("post message") do
      name = @new_workspace.channels.first.name
      @new_workspace.select_channel(name)
      response = @new_workspace.send_message("This is a test!")
      expect(response).must_equal true
    end
  end

  it "can send a valid message with name to a user" do
    VCR.use_cassette("post message") do
      name = @new_workspace.users.first.name
      @new_workspace.select_user(name)
      response = @new_workspace.send_message("This is a test!")
      expect(response).must_equal true
    end
  end

  it "will raise an error if the channel is nil or invalid" do
    VCR.use_cassette("post message") do
      @new_workspace.select_channel("")
      expect {
        @new_workspace.send_message("This is a test!")
      }.must_raise SlackCLI::SlackApiError
    end
  end

  it "will raise an error if the user is nil or invalid" do
    VCR.use_cassette("post message") do
      @new_workspace.select_user("")
      expect {
        @new_workspace.send_message("This is a test!")
      }.must_raise SlackCLI::SlackApiError
    end
  end
end

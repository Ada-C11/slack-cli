require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/workspace.rb"

describe "Workspace class" do
  before do
    VCR.use_cassette("workspace_creation") do
      #query_params = { token: ENV["SLACK_API_TOKEN"] }
      @workspace = Slack::Workspace.new
    end
  end

  it "creates an instance of Workspace" do
    expect(@workspace).must_be_kind_of Slack::Workspace
  end

  it "has an array of Users" do
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.users[0]).must_be_kind_of Slack::User
  end

  it "has an array of Channels" do
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.channels[0]).must_be_kind_of Slack::Channel
  end

  it "can select a Channel" do
    @workspace.select_channel("CH0EE9NJC")
    expect(@workspace.selected).must_be_kind_of Slack::Channel
  end

  it "Channel returns nil if given invalid id" do
    @workspace.select_channel("INVALID_ID")
    expect(@workspace.selected).must_equal nil
  end

  it "can select a User" do
    @workspace.select_user("USLACKBOT")
    expect(@workspace.selected).must_be_kind_of Slack::User
  end

  it "User returns nil if given invalid id" do
    @workspace.select_user("INVALID_ID")
    expect(@workspace.selected).must_equal nil
  end
end

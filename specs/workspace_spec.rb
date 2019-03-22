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

  describe "select_channel" do
    it "can select a Channel based on id" do
      @workspace.select_channel("CH0EE9NJC")
      expect(@workspace.selected).must_be_kind_of Slack::Channel
    end

    it "returns nil if given invalid id" do
      @workspace.select_channel("INVALID_ID")
      expect(@workspace.selected).must_equal nil
    end
  end

  describe "select_user" do
    it "can select a User based on id" do
      @workspace.select_user("USLACKBOT")
      expect(@workspace.selected).must_be_kind_of Slack::User
    end

    it "returns nil if given invalid id" do
      @workspace.select_user("INVALID_ID")
      expect(@workspace.selected).must_equal nil
    end

    describe "show_details" do
      # tests for show_details here
    end
  end
end

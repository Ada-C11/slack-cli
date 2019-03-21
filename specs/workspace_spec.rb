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
  end
end

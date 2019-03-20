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
    before do 
      @username = @workspace.users.first.name
    end
    it "should return an instance of User, given valid input" do
      
      expect(@workspace.select_user(@username)).must_be_kind_of SlackCLI::User
      expect(@workspace.selected).must_be_kind_of SlackCLI::User
      expect(@workspace.selected).must_equal @workspace.users.first
    end
    # add after select_channel is implemented
    # it "should update selected when a new user is selected" do
    #   @workspace.select_channel(channel)
    #   username2 = @workspace.users[1].name
    #   expect(@workspace.selected).must_equal @workspace.users[1]
    # end

    it "should return nil, given invalid user" do
      bad_username = ""
      @workspace.select_user(bad_username)
      expect(@workspace.selected).must_be_nil
    end
  end
end

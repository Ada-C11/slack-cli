require_relative "test_helper"

describe SlackCLI::Workspace do
  describe "constructor" do
    before do
      VCR.use_cassette("workspace") do
        @workspace = Workspace.new
      end
    end

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
end
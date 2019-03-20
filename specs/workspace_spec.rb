require_relative "test_helper"

describe "Workspace class" do
  describe "initialize" do
    it "creates a list of channels and users" do
      VCR.use_cassette("slack_workspace") do
        workspace = Workspace.new
        expect(workspace.channels.first).must_be_kind_of Channel

        expect(workspace.users.first).must_be_kind_of User
      end
    end
  end

  describe "instance methods" do
    it "returns text from print_details" do
      VCR.use_cassette("slack_workspace") do
        workspace = Workspace.new
        expect(workspace.print_details("users")).must_be_kind_of String

        expect(workspace.print_details("channels")).must_be_kind_of String
      end
    end

    it "returns a user object from select_user" do
      VCR.use_cassette("slack_workspace") do
        workspace = Workspace.new
        expect(workspace.select_user("slackbot")).must_be_kind_of User

        expect(workspace.select_user("USLACKBOT")).must_be_kind_of User
      end
    end
  end
end

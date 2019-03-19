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
end

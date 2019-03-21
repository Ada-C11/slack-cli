require_relative "test_helper"

describe "Workspace class" do
  before(:each) do
    VCR.insert_cassette("workspace_response")
  end
  after(:each) do
    VCR.eject_cassette
  end
  let(:workspace) {
    workspace = Workspace.new
  }

  describe "initialize" do
    it "returns an array of User instances" do
      expect(workspace.users).must_be_kind_of Array
      expect(workspace.users.first).must_be_instance_of SlackCli::User
      expect(workspace.users.last).must_be_instance_of SlackCli::User
    end

    it "returns an array of Channel instances" do
      expect(workspace.channels).must_be_kind_of Array
      expect(workspace.channels.first).must_be_instance_of SlackCli::Channel
      expect(workspace.channels.last).must_be_instance_of SlackCli::Channel
    end

    it "@selected is nil prior to selecting a user or channel" do 
      assert_nil(workspace.selected)
    end
  end

  describe "select_channel method" do
    it "returns selected instance of channel" do
      expect(workspace.select_channel("everyone")).must_be_instance_of SlackCli::Channel
      expect(workspace.select_channel("everyone").name).must_equal "everyone"
      expect(workspace.selected.name).must_equal "everyone"
      expect(workspace.selected.slack_id).must_equal "CH2RAKATW"
    end

    it "returns nil if no channel selected" do
      expect(workspace.select_channel("")).must_equal nil
    end
  end

  describe "select_user method" do
    it "returns selected instance of user" do
      expect(workspace.select_user("hanalways")).must_be_instance_of SlackCli::User
      expect(workspace.select_user("tatsqui").name).must_equal "tatsqui"
      expect(workspace.selected.name).must_equal "tatsqui"
      expect(workspace.selected.slack_id).must_equal "UH2NZ7X7V"
    end

    it "returns nil if no user selected" do
      assert_nil(workspace.select_user(""))
    end
  end

  describe "cases when our program should raise an exception created by user" do 
  end

  describe "cases when our program should raise an exception created by changes to API" do 
  end
end

require_relative 'test_helper'

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
      expect(workspace.users.first).must_be_kind_of SlackCli::User
    end

    it "returns an array of Channel instances" do 
      expect(workspace.channels).must_be_kind_of Array 
      expect(workspace.channels.first).must_be_kind_of SlackCli::Channel
    end

    it "returns nil for no selected class" do
      expect(workspace.selected).must_equal nil
    #   expect {
    #     workspace.selected
    #   }.must_raise SlackCli::SlackError
    end      
  end

  describe "select_channel method" do 
    it "returns selected instance of channel" do 
      expect(workspace.select_channel("everyone")).must_be_instance_of SlackCli::Channel
      expect(workspace.select_channel("everyone").name).must_equal "everyone"
    end

    it "returns nil if no channel selected" do 
      expect(workspace.select_channel("")).must_equal nil
    end
  end

  describe "select_user method" do 
    it "returns selected instance of user" do 
      expect(workspace.select_user("hanalways")).must_be_instance_of SlackCli::User
      expect(workspace.select_user("tatsqui").name).must_equal "tatsqui"
    end

    it "returns nil if no user selected" do 
      expect(workspace.select_user("")).must_equal nil
    end
  end
end
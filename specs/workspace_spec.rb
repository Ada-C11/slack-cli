require_relative "test_helper"

describe "Workspace class" do
  before do
    VCR.use_cassette("slack_api") do
      @workspace = Slack::Workspace.new
    end
  end

  describe "Workspace#initialize" do
    it "returns a workspace object" do
      expect(@workspace).must_be_instance_of Slack::Workspace
    end

    it "responds to instance variable and selected is nil" do
      expect(@workspace).must_respond_to :channels
      expect(@workspace).must_respond_to :users
      expect(@workspace).must_respond_to :selected
      expect(@workspace.selected).must_be_nil
    end
  end
end

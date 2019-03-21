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
  end
end

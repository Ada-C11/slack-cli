require_relative "test_helper"

describe "Workspace" do
  # let(:workspace) { Slack::Workspace.new }
  describe "Initialization" do
    it "can be instantiated" do
      VCR.use_cassette("workspace") do
        workspace = Slack::Workspace.new
        expect(workspace).must_be_instance_of Slack::Workspace
      end
    end

    it "establishes the base structures when instantiated" do
      VCR.use_cassette("workspace") do
        workspace = Slack::Workspace.new
        expect(workspace)
        [:users, :channels, :selected].each do |prop|
          expect(workspace).must_respond_to prop
        end

        expect(workspace.users).must_be_kind_of Array
        expect(workspace.channels).must_be_kind_of Array
        expect(workspace.selected).must_equal nil
      end
    end
  end
end

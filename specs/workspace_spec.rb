require_relative "test_helper"

describe "Workspace" do
  let(:workspace) { Slack::Workspace.new }
  describe "Initialization" do
    it "can be instantiated" do
      expect(workspace).must_be_instance_of Slack::Workspace
    end

    it "establishes the base structures when instantiated" do
      [:users, :channels, :selected].each do |prop|
        expect(workspace).must_respond_to prop
      end

      expect(workspace.users).must_be_kind_of Array
      expect(workspace.channels).must_be_kind_of Array
      expect(workspace.selected).must_equal nil
    end
  end
end

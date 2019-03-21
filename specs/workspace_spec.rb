require_relative "test_helper"

describe SlackApi::Workspace do
  before do
  end
  describe "select_channel" do
    it "selects a valid channel" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        valid_channel_name = "random"
        expect(workspace.select_channel(valid_channel_name)).must_equal true
      end
    end

    # it "returns false if an invalid channel is attempted to be selected" do
    #   skip
    #   VCR.use_cassette("slack_workspace") do
    #   end
    # end
  end

  #   describe "select_user" do
  #     it "selects a valid user" do
  #       skip
  #       VCR.use_cassette("slack_workspace") do
  #       end
  #     end

  #     it "returns a false if an invalid user is attempted to be selected" do
  #       skip
  #       VCR.use_cassette("slack_workspace") do
  #       end
  #     end
  #   end

  #   describe "show_details" do
  #     it "returns details for the correct recipient" do
  #       skip
  #       VCR.use_cassette("slack_workspace") do
  #       end
  #     end

  #     it "returns an error message if no recipient has been selected" do
  #       skip
  #       VCR.use_cassette("slack_workspace") do
  #       end
  #     end
  #   end
end

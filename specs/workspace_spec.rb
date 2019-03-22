require_relative "test_helper"

describe SlackApi::Workspace do
  describe "select_channel" do
    it "selects a valid channel name" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        valid_channel_name = "random"
        expect(workspace.select_channel(valid_channel_name)).must_equal true
      end
    end

    it "selects a valid channel ID" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        valid_channel_id = "CH3UGLBHV"
        expect(workspace.select_channel(valid_channel_id)).must_equal true
      end
    end

    it "returns false if an invalid channel is attempted to be selected" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        invalid_channel_name = "not a channel"
        expect(workspace.select_channel(invalid_channel_name)).must_equal false
      end
    end

    it "returns a false if select_channel is not given an input" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        expect(workspace.select_channel("")).must_equal false
      end
    end
  end

  describe "select_user" do
    it "selects a valid username" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        valid_user_name = "slackbot"
        expect(workspace.select_user(valid_user_name)).must_equal true
      end
    end

    it "selects a valid user ID" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        valid_user_id = "USLACKBOT"
        expect(workspace.select_user(valid_user_id)).must_equal true
      end
    end

    it "returns a false if an invalid user is attempted to be selected" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        invalid_user_name = "smackbot"
        expect(workspace.select_user(invalid_user_name)).must_equal false
      end
    end

    it "returns a false if select_user is not given an input" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        expect(workspace.select_user("")).must_equal false
      end
    end
  end

  describe "show_details" do
    it "returns details for the correct channel" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        workspace.select_channel("random")

        expect(workspace.show_details).must_include "CH3UGLBHV"
      end
    end

    it "returns details for the correct user" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new
        workspace.select_user("slackbot")

        expect(workspace.show_details).must_include "USLACKBOT"
      end
    end

    it "returns an error message if no recipient has been selected" do
      VCR.use_cassette("slack_workspace") do
        workspace = SlackApi::Workspace.new

        expect(workspace.show_details).must_include "You have not selected a user or channel yet."
      end
    end
  end

  describe "send_message" do
    it "can send a valid message to a channel" do
      VCR.use_cassette("slack_message") do
        workspace = SlackApi::Workspace.new
        workspace.select_channel("general")
        return_value = workspace.send_message("This is a message!")

        expect(return_value).must_equal true
      end
    end

    it "returns error message if no recipient has been selected yet" do
      VCR.use_cassette("slack_message") do
        workspace = SlackApi::Workspace.new
        return_value = workspace.send_message("This is a message!")

        expect(return_value).must_include "You have not selected a user or channel yet."
      end
    end

    it "will raise an error if given an empty message" do
        VCR.use_cassette("slack_message") do
            workspace = SlackApi::Workspace.new
            workspace.select_channel("general")
          expect {
            workspace.send_message("")
          }.must_raise SlackApi::SlackError
        end
      end
  end
end

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
      assert_nil(workspace.select_channel(""))
      assert_nil(workspace.select_channel(nil))
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
      assert_nil(workspace.select_user(nil))
    end
  end

  describe "send message" do
    it "can post a message on the 'everyone' slack channel" do
      workspace.select_channel("everyone")
      text = "hello world"
      pigeon = workspace.send_message(text)

      expect(pigeon["ok"]).must_equal true
    end
  end

  describe "show details method" do
    it "returns details for a selected user" do
      workspace.select_user("hanalways")
      expect(workspace.show_details).must_be_kind_of String
    end

    it "returns details for a selected channel" do
      workspace.select_channel("everyone")
      expect(workspace.show_details).must_be_kind_of String
    end

    it "must raise SlackError for no selected user or channel" do
      workspace.select_channel("")
      expect {
        workspace.show_details
      }.must_raise SlackCli::SlackError

      workspace.select_user("")
      expect {
        workspace.show_details
      }.must_raise SlackCli::SlackError
    end
  end

  describe "send_message method" do
    it "raise an exception when a trying to send a nil or blank message to a channel or user" do
      workspace.select_user("tatsqui")
      no_text = ""
      expect { workspace.send_message(no_text) }.must_raise SlackCli::SlackError
    end

    it "will raise and exception with a nil message" do
      message = nil
      expect { workspace.send_message(message) }.must_raise SlackCli::SlackError
    end

    it "successfully sends a message with selected user" do
      workspace.select_user("tatsqui")
      test_message = workspace.send_message("test")
      expect(test_message["ok"]).must_equal true
    end
  end

  describe "list_channels method" do
    it "returns details of a channel as nil" do
      assert_nil(workspace.list_channels)
    end
  end

  describe "list_users method" do
    it "returns details of a user as nil" do
      assert_nil(workspace.list_users)
    end
  end
end

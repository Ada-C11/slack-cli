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

  describe "cases when our program should raise an exception..." do
    it "should raise an exception created by changes to API" do
      class Dummy < SlackCli::Recipient
        LIST_URL = "http://slack.com/api/users.list"
        BADTOKEN = "123"
        def self.get
          query_params = {
            token: BADTOKEN,
          }
          response = HTTParty.get(self::LIST_URL, query: query_params)
          # error_helper(response)
          return response
        end
      end

      test_dummy = Dummy.get
      expect(test_dummy["ok"]).must_equal false
      expect(test_dummy["error"]).must_equal "invalid_auth"
    end

    it "should raise an exception created by changes to API URI" do
      class Dummy < SlackCli::Recipient
        LIST_URL = "http://slack.com/api/users.lis"
        def self.get
          query_params = {
            token: TOKEN,
          }
          response = HTTParty.get(self::LIST_URL, query: query_params)
          # error_helper(response)
          return response
        end
      end

      test_dummy = Dummy.get
      expect(test_dummy["ok"]).must_equal false
      expect(test_dummy["req_method"]).must_equal "users.lis"
    end

    it "raise an exception when a user enters nil in send_message" do
      message = ""
      expect { workspace.send_message(message) }.must_raise SlackCli::SlackError
    end
  end
end

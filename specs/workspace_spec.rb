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

    it "has correct instance variable types" do
      expect(@workspace.channels[1]).must_be_instance_of Slack::Channel
      expect(@workspace.users[1]).must_be_instance_of Slack::User
    end
  end

  describe "Workspace#Select_channel" do
    it "will set the selected variable to input channel and returns true" do
      expect(@workspace.select_channel(channel: @workspace.channels[1])).must_equal true
      expect(@workspace.selected).must_equal @workspace.channels[1]
    end
  end

  describe "Workspace#Select_user" do
    it "will set the selected variable to input user" do
      @workspace.select_user(user: @workspace.users[1])
      expect(@workspace.selected).must_equal @workspace.users[1]
    end
  end

  describe "Workspace#list_all" do
    it "will return a string" do
      expect(@workspace.list_all(list: @workspace.channels)).must_be_instance_of String
      expect(@workspace.list_all(list: @workspace.users)).must_be_instance_of String
    end

    it "will return the correct String format" do
      test_list = @workspace.list_all(list: @workspace.channels)
      expected_result = "Name: slack-api-project, \nID: CH0EG6M0Q, \nTopic: , \nMember Count: 2\n" +
                        "-----------------------\n" +
                        "Name: general, \nID: CH2P3NB0T, \nTopic: Company-wide announcements and work-based matters, \nMember Count: 2\n" +
                        "-----------------------\n" +
                        "Name: random, \nID: CH2RH8AMA, \nTopic: Non-work banter and water cooler conversation, \nMember Count: 2\n" +
                        "-----------------------\n" +
                        "Name: super-awesome-stuffs, \nID: CH3UNG023, \nTopic: , \nMember Count: 2\n" +
                        "-----------------------\n"
      expect(test_list).must_equal expected_result
    end

    it "will return the correct String format" do
      test_list = @workspace.list_all(list: @workspace.users)
      expected_result = "Name: slackbot, \nReal Name: Slackbot, \nID: USLACKBOT\n" +
                        "-----------------------\n" +
                        "Name: elise.pham88, \nReal Name: elise.pham88, \nID: UH2RH81RA\n" +
                        "-----------------------\n" +
                        "Name: s.dippolito, \nReal Name: Sav Dippolito, \nID: UH3UN350X\n" +
                        "-----------------------\n"
      expect(test_list).must_equal expected_result
    end
  end
end

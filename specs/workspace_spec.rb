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

  describe "Workspace#send_message" do
    it "will return true if post succesful" do
      VCR.use_cassette("slack_api") do
        @workspace.select_channel(channel: @workspace.channels[1])
        expect(@workspace.send_message(text: "Something new to test!")).must_equal true
      end
    end

    it "will return false if post is unsuccessful" do
      VCR.use_cassette("slack_api") do
        expect(@workspace.send_message(text: "Something new to test!")).must_equal false
        @workspace.select_channel(channel: @workspace.channels[1])
        expect(@workspace.send_message(text: "")).must_equal false
      end
    end
  end

  describe "Workspace#details_for_selected" do
    it "will return a String" do
      expect(@workspace.details_for_selected).must_be_instance_of String
    end

    it "will return string details of selected object if valid" do
      @workspace.select_channel(channel: @workspace.channels[1])
      expect(@workspace.details_for_selected).must_equal "Name: general, \nID: CH2P3NB0T, \nTopic: Company-wide announcements and work-based matters, \nMember Count: 2"
    end

    it "will return empty string if selected object is nil" do
      expect(@workspace.details_for_selected).must_equal ""
    end
  end

  describe "Workspace#find_user" do
    it "will return a user object, given a valid user's name, real_name or id" do
      user_name = "elise.pham88"
      real_name = "elise.pham88"
      user_id = "UH2RH81RA"
      user = @workspace.find_user(input: user_name.upcase)
      expect(user).must_be_instance_of Slack::User
      expect(user.name).must_equal "elise.pham88"
      user = @workspace.find_user(input: real_name.upcase)
      expect(user).must_be_instance_of Slack::User
      expect(user.real_name).must_equal "elise.pham88"
      user = @workspace.find_user(input: user_id.upcase)
      expect(user).must_be_instance_of Slack::User
      expect(user.id).must_equal "UH2RH81RA"
    end

    it "will return nil if invalid users name, real_name or id" do
      user_name = "elissdfsdfe.pham88"
      real_name = "elisesdfsdf.pham88"
      user_id = "UH2RHsdfsdf81RA"
      expect(@workspace.find_user(input: user_name.upcase)).must_be_nil
      expect(@workspace.find_user(input: real_name.upcase)).must_be_nil
      expect(@workspace.find_user(input: user_id.upcase)).must_be_nil
    end
  end

  describe "Workspace#find_channel" do
    it "will return a user object, given a valid channel's name or id" do
      channel_name = "random"
      channel_id = "CH2RH8AMA"
      channel = @workspace.find_channel(input: channel_name.upcase)
      expect(channel).must_be_instance_of Slack::Channel
      expect(channel.name).must_equal "random"
      channel = @workspace.find_channel(input: channel_id.upcase)
      expect(channel).must_be_instance_of Slack::Channel
      expect(channel.id).must_equal "CH2RH8AMA"
    end
  end
end

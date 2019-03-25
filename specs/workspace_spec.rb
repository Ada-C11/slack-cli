require_relative "test_helper"

describe "Workspace Class" do
  describe "initialize method" do
    it "lists users and channels" do
      VCR.use_cassette("workspace information") do
        workspace = Slack::Workspace.new
        expect(workspace.users).must_be_kind_of(Array)
        expect(workspace.channels).must_be_kind_of(Array)
        (0..1).each do |i|
          expect(workspace.users[i]).must_be_kind_of(Slack::User)
          expect(workspace.channels[i]).must_be_kind_of(Slack::Channel)
        end
      end
    end
  end

  describe "select user method" do
    it "stores user inputted username in selection variable" do
      VCR.use_cassette("workspace information") do
        user_names = ["smarcha04", "faiza.ahsan1222", "slackbot"]
        real_names = ["Stephanie Marchante", "Faiza Husain", "Slackbot"]
        workspace = Slack::Workspace.new

        user_names.each_with_index do |user_name, i|
          find_user = workspace.select_user(user_name)
          selected_user = workspace.selection
          expect(selected_user).must_be_kind_of Slack::User
          expect(selected_user.real_name).must_equal "#{real_names[i]}"
        end
      end
    end

    it "stores user inputted slackid in selection variable" do
      VCR.use_cassette("workspace information") do
        all_slack_ids = ["UH2NWFHTM", "UH2NX89A7", "USLACKBOT"]
        all_real_names = ["Faiza Husain", "Stephanie Marchante", "Slackbot"]

        workspace = Slack::Workspace.new

        all_slack_ids.each_with_index do |slackid, i|
          user_search = workspace.select_user(slackid)
          select_user = workspace.selection
          expect(select_user).must_be_kind_of(Slack::User)
          expect(select_user.real_name).must_equal "#{all_real_names[i]}"
        end
      end
    end

    it "returns error message if user input slackid or user name are invalid" do
      VCR.use_cassette("workspace information") do
        workspace = Slack::Workspace.new
        user_search = workspace.select_user("steph steph")
        selected_user = workspace.selection
        assert_nil(selected_user, msg = nil)
      end
    end
  end

  describe "select channel method" do
    it "finds a channel by name and stores it in the selected variable" do
      VCR.use_cassette("workspace information") do
        channel_names = ["general", "random"]
        topics = ["Company-wide announcements and work-based matters", "Non-work banter and water cooler conversation"]
        workspace = Slack::Workspace.new

        channel_names.each_with_index do |channel_name, i|
          workspace.select_channel(channel_name)
          expect(workspace.selection).must_be_kind_of Slack::Channel
          expect(workspace.selection.topic).must_equal "#{topics[i]}"
        end
      end
    end

    # it "finds a channel by slack id and stores it in the selected variable" do
    #   VCR.use_cassette("workspace information") do
    #     slack_ids = ["CH2RA1JMS", "CH36MD2ER"]
    #     topics = ["Company-wide announcements and work-based matters", "Non-work banter and water cooler conversation"]
    #     workspace = Slack::Workspace.new

    #     slack_ids.each_with_index do |slack_id, i|
    #       expect(workspace.selection).must_be_kind_of(String)
    #       expect(workspace.select_channel(slack_id)).must_equal "#{i.topics[i]}"
    #     end
    #   end
    # end
  end

  it "gives an error message if user name or slack id ar invalid" do
    VCR.use_cassette("workspace information") do
      workspace = Slack::Workspace.new
      search_channel = workspace.select_channel("crazy cat lady")
      selected_channel = workspace.selection
      assert_nil(selected_channel, msg = nil)
    end
  end

  describe "Show details method" do
    it "returns details" do
    end
    it "returns false boolean if invalid user or channel is passed in" do
      VCR.use_cassette("workspace information") do
        workspace = Slack::Workspace.new
        puts "BBBBBBBBBBBB"
        puts "#{workspace}"
        chosen_user = workspace.select_user("FaiFai")
        expect(chosen_user).must_be_kind_of(String)

        chosen_user2 = workspace.select_channel("Thomas")
        expect(chosen_user2).must_be_kind_of(String)
      end
    end
  end

  describe "send message method" do
    it "sends a message if all requirements are met" do
      VCR.use_cassette("recipient send message") do
        workspace = Slack::Workspace.new
        workspace.select_user("smarcha04")
        message = workspace.send_message("Man I love playing guitar.")
        expect(message).must_equal(true)
      end
    end

    it "returns false if no channel or user are selected" do
      VCR.use_cassette("recipient send message") do
        workspace = Slack::Workspace.new
        message = workspace.send_message("Man I love playing guitar.")
        expect(message).must_equal false
      end
    end

    it "returns nil if incorrect message is inputted" do
      VCR.use_cassette("recipient send message") do
        workspace = Slack::Workspace.new
        message = workspace.send_message("")
        expect(message).must_equal false
      end
    end
  end
end

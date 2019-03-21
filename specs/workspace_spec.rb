require_relative "test_helper"

describe "Workspace Class" do
  describe "#initialize" do
    it "has a list of users & a list of channels" do
      VCR.use_cassette("workspace_information_find") do
        workspace = Slack::Workspace.new
        expect(workspace.users).must_be_kind_of Array
        expect(workspace.channels).must_be_kind_of Array
        (0..2).each do |i|
          expect(workspace.users[i]).must_be_kind_of Slack::User
          expect(workspace.channels[i]).must_be_kind_of Slack::Channel
        end
      end
    end
  end

  describe "#select_user" do
    it "finds a user by username and stores it in the selected variable" do
      VCR.use_cassette("workspace_information_find") do
        user_names = ["kimberly.fasbender", "scarlettsteph07", "cloudylopez"]
        real_names = ["Kim Fasbender", "Scarlett", "Cloudy Lopez"]
        workspace = Slack::Workspace.new

        user_names.each_with_index do |user_name, i|
          find_user = workspace.select_user(user_name)
          selected_user = workspace.selected
          expect(selected_user).must_be_kind_of Slack::User
          expect(selected_user.real_name).must_equal "#{real_names[i]}"
        end
      end
    end

    it "finds a user by slack id and stores it in the selected variable" do
      VCR.use_cassette("workspace_information_find") do
        slack_ids = ["UH408BVL7", "UH5EEFU0N", "UH599D6J0"]
        real_names = ["Kim Fasbender", "Cloudy Lopez", "Scarlett"]
        workspace = Slack::Workspace.new

        slack_ids.each_with_index do |slack_id, i|
          find_user = workspace.select_user(slack_id)
          selected_user = workspace.selected
          expect(selected_user).must_be_kind_of Slack::User
          expect(selected_user.real_name).must_equal "#{real_names[i]}"
        end
      end
    end

    it "returns an error message if user_name or slack_id are invalid" do
      VCR.use_cassette("workspace_information_find") do
        workspace = Slack::Workspace.new
        find_user = workspace.select_user("potato daniels")
        selected_user = workspace.selected
        assert_nil(selected_user, msg = nil)
      end
    end
  end

  describe "#select_channel" do
    it "finds a channel by name and stores it in the selected variable" do
      VCR.use_cassette("workspace_information_find") do
        channel_names = ["puppers", "general", "random"]
        topics = ["All doggos all the time! :dog:",
                  "Company-wide announcements and work-based matters",
                  "Non-work banter and water cooler conversation"]
        workspace = Slack::Workspace.new

        channel_names.each_with_index do |channel_name, i|
          find_channel = workspace.select_channel(channel_name)
          selected_channel = workspace.selected
          expect(selected_channel).must_be_kind_of Slack::Channel
          expect(selected_channel.topic).must_equal "#{topics[i]}"
        end
      end
    end

    it "finds a channel by slack id and stores it in the selected variable" do
      VCR.use_cassette("workspace_information_find") do
        slack_ids = ["CH317B6EN", "CH408C1CP", "CH4AZQMJS"]
        topics = ["All doggos all the time! :dog:",
                  "Company-wide announcements and work-based matters",
                  "Non-work banter and water cooler conversation"]
        workspace = Slack::Workspace.new

        slack_ids.each_with_index do |slack_id, i|
          find_channel = workspace.select_channel(slack_id)
          selected_channel = workspace.selected
          expect(selected_channel).must_be_kind_of Slack::Channel
          expect(selected_channel.topic).must_equal "#{topics[i]}"
        end
      end
    end

    it "returns an error message if user_name or slack_id are invalid" do
      VCR.use_cassette("workspace_information_find") do
        workspace = Slack::Workspace.new
        find_channel = workspace.select_channel("potato daniels")
        selected_channel = workspace.selected
        assert_nil(selected_channel, msg = nil)
      end
    end

    describe "#show_details" do
      it "returns an instance of table_print when a valid paramter is passed" do
        VCR.use_cassette("workspace_information_find") do
          workspace = Slack::Workspace.new
          select_user = workspace.select_user("kimberly.fasbender")
          expect(workspace.show_details).must_be_kind_of TablePrint::Returnable

          select_channel = workspace.select_channel("puppers")
          expect(workspace.show_details).must_be_kind_of TablePrint::Returnable
        end
      end

      it "returns false if an invalid channel/user is passed to it" do
        VCR.use_cassette("workspace_information_find") do
          workspace = Slack::Workspace.new
          select_user = workspace.select_user("Reginald")
          expect(workspace.show_details).must_equal false

          select_channel = workspace.select_channel("Thomas")
          expect(workspace.show_details).must_equal false
        end
      end
    end

    # select_channel end
  end
  # end end
end

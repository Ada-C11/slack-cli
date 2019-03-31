require_relative "test_helper.rb"

describe "self.channel_list_all" do
  it "returns an array of channel names" do
    VCR.use_cassette("channel_find") do
      list = Slack::Workspace.channel_list_all

      expect(list.length).must_equal 3
      expect(list).must_include "random"
      expect(list).wont_include "test"
    end
  end
end

describe "self.all_channels_details" do
  it "returns an array of channel details" do
    VCR.use_cassette("channel_find") do
      details = Slack::Workspace.all_channels_details

      expect(details.length).must_equal 3
    end
  end
end

describe "self.select_channel" do
  it "can select a channel and return it" do
    VCR.use_cassette("channel_find") do
      selected_channel = Slack::Workspace.select_channel("general")

      expect(selected_channel.name).must_equal "general"
      expect(selected_channel.slack_id).must_equal "CH2NW42JF"

      selected_channel = Slack::Workspace.select_channel("CH2NW42JF")

      expect(selected_channel.name).must_equal "general"
      expect(selected_channel.slack_id).must_equal "CH2NW42JF"

      selected_channel = Slack::Workspace.select_channel("geNeral")
      expect(selected_channel.name).must_equal "general"
    end
  end
end

describe "self.selected_channel_details" do
  it "returns the details for the selected channel" do
    VCR.use_cassette("channel_find") do
      channel = Slack::Channel.new("Pfeiffer_id", "Pfeiffer_name", 5, "Pfeiffer_topic")
      channel_details = Slack::Workspace.selected_channel_details(channel)

      expect(channel_details).must_match "Pfeiffer_id"
      expect(channel_details).must_match "Pfeiffer_topic"
    end
  end
end

describe "self.user_list_all" do
  it "returns an array of user names" do
    VCR.use_cassette("user_find") do
      list = Slack::Workspace.user_list_all
      expect(list.length).must_equal 3
      expect(list).must_include "slackbot"
      expect(list).wont_include "test"
    end
  end
end

describe "self.all_users_details" do
  it "returns an array of users details" do
    VCR.use_cassette("user_find") do
      details = Slack::Workspace.all_users_details

      expect(details.length).must_equal 3
    end
  end
end

describe "self.select_user" do
  it "can select a user and return it" do
    VCR.use_cassette("user_find") do
      selected_user = Slack::Workspace.select_user("slackbot")

      expect(selected_user.name).must_equal "slackbot"
      expect(selected_user.slack_id).must_equal "USLACKBOT"

      selected_user = Slack::Workspace.select_user("USLACKBOT")

      expect(selected_user.name).must_equal "slackbot"
      expect(selected_user.slack_id).must_equal "USLACKBOT"

      selected_user = Slack::Workspace.select_user("USLACKbOT")
      expect(selected_user.name).must_equal "slackbot"
    end
  end
end

describe "self.selected_user_details" do
  it "returns the details for the selected user" do
    VCR.use_cassette("user_find") do
      user = Slack::User.new("RS100", "Robot", "Robot Smith")
      user_details = Slack::Workspace.selected_user_details(user)

      expect(user_details).must_match "RS100"
      expect(user_details).must_match "Robot Smith"
    end
  end
end

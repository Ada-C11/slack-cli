require_relative "test_helper.rb"

describe "self.select_channel" do
  it "can select a channel and return it" do
    VCR.use_cassette("channel_find") do
      selected_channel = Slack::Workspace.select_channel("general")

      expect(selected_channel.name).must_equal "general"
      expect(selected_channel.slack_id).must_equal "CH2NW42JF"

      selected_channel = Slack::Workspace.select_channel("CH2NW42JF")

      expect(selected_channel.name).must_equal "general"
      expect(selected_channel.slack_id).must_equal "CH2NW42JF"
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
    end
  end
end

require_relative "test_helper"

describe "select_channel" do
  it "selects a channel as the current recipient when user inputs channel ID" do
    channel_url = "channels.list"
    channel = SlackAPI::Workspace.new()

    VCR.use_cassette("select_channel") do
      response = channel.select_channel("CH2SKTKPC")
      expect(response).must_equal "CH2SKTKPC"
    end
  end
  it "selects a channel as the current recipient when user inputs channel name" do
    channel = SlackAPI::Workspace.new()
    VCR.use_cassette("select_channel") do
      response = channel.select_channel("general")
      expect(response).must_equal "general"
    end
  end
  it "raises an error if the channel is not valid" do
    channel = SlackAPI::Workspace.new()
    VCR.use_cassette("select_channel") do
      expect { channel.select_channel("fake channel") }.must_raise SlackAPI::SlackError
    end
  end
end

describe "see_details" do
  it "shows details for a selected channel" do
    channel = SlackAPI::Workspace.new()
    VCR.use_cassette("see_details_2") do
      selected_channel = channel.select_channel("CH2SKTKPC")
      channel_details = channel.see_channel_details("CH2SKTKPC")

      expect(channel_details).must_be_kind_of Array
      expect(channel_details.length).must_equal 1
      expect(channel_details[0]).must_equal "name" => "general", "topic" => "Company-wide announcements", "member count" => 2, "id" => "CH2SKTKPC"
    end
  end
end

# TESTS FOR USERS

describe "select_user" do
  it "selects a user as the current recipient when user inputs ID" do
    user = SlackAPI::Workspace.new
    VCR.use_cassette("select_user") do
      response = user.select_user("UH3UT3SJK")
      expect(response).must_equal "UH3UT3SJK"
    end
  end
  it "selects a user as the current recipient when user inputs name" do
    user = SlackAPI::Workspace.new
    VCR.use_cassette("select_user") do
      response = user.select_user("aribray")
      expect(response).must_equal "UH3UT3SJK"
    end
  end
  it "raises a SlackError if the user's name or id is invalid" do
    user = SlackAPI::Workspace.new
    VCR.use_cassette("select_user") do
      expect { user.select_user("fakeuser") }.must_raise SlackAPI::SlackError
    end
  end
end

describe "see_details" do
  it "shows details for selected user" do
    user = SlackAPI::Workspace.new
    VCR.use_cassette("see_details_1") do
      selected_user = user.select_user("UH3UT3SJK")
      user_details = user.see_user_details(selected_user)

      expect(user_details).must_be_kind_of Array
      expect(user_details.length).must_equal 1
      expect(user_details[0]).must_equal "name" => "aribray", "real name" => "Ariana Bray", "slack id" => "UH3UT3SJK"
    end
  end
end

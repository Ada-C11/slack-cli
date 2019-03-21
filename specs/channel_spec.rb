require_relative "test_helper"

describe "self.list" do
  it "list all channels" do
    VCR.use_cassette("list_channels") do
      response = SlackAPI::Channel.list_channels
      puts response

      expect(response).wont_be_nil
      expect(response.keys.include?("general")).must_equal true
      expect(response["general"]).must_equal "topic" => "Company-wide announcements and work-based matters",
        "member count" => 2,
        "id" => "CH2SKTKPC"
      expect(response.length).must_equal 3
    end
  end
  it "will raise an error if the response code is not 200" do
    #fill this in later
  end
end

describe "select_channel" do
  it "selects a channel as the current recipient when user inputs channel ID" do
    channel_url = "channels.list"
    channel = SlackAPI::Channel.new()

    VCR.use_cassette("select_channel") do
      response = channel.select_channel("CH2SKTKPC")
      expect(response).must_equal "CH2SKTKPC"
    end
  end
  it "selects a channel as the current recipient when user inputs channel name" do
    channel = SlackAPI::Channel.new()
    VCR.use_cassette("select_channel") do
      response = channel.select_channel("general")
      expect(response).must_equal "general"
    end
  end
  it "raises an error if the channel is not valid" do
    channel = SlackAPI::Channel.new()
    VCR.use_cassette("select_channel") do
      expect { channel.select_channel("fake channel") }.must_raise SlackAPI::SlackError
    end
  end
end

describe "see_details" do
  it "shows details for a selected channel" do
    channel = SlackAPI::Channel.new()
    VCR.use_cassette("see_details") do
      selected_channel = channel.select_channel("CH2SKTKPC")
      channel_details = channel.see_details("CH2SKTKPC")

      expect(channel_details).must_be_kind_of Hash
      expect(channel_details.length).must_equal 1
      expect(channel_details["general"]).must_equal "topic" => "Company-wide announcements and work-based matters",
                                                    "member count" => 2, "id" => "CH2SKTKPC"
    end
  end
end

describe "send_msg" do
  it "sends a message to selected channel" do
    channel = SlackAPI::Channel.new()
    VCR.use_cassette("see_details") do
      selected_channel = channel.select_channel("CH2SKTKPC")
      msg = channel.send_msg("CH2SKTKPC", "This is a test message!")
      expect(msg).must_equal true
    end
  end
end

require_relative "test_helper"

describe SlackApi::Channel do
  describe "json channels" do
    it "returns valid channels" do
      VCR.use_cassette("slack_channels_json") do
        url = "https://slack.com/api/channels.list"
        key = ENV["SLACK_API_TOKEN"]
        channels_list = SlackApi::Channel.channel_api(url, key)

        channels_list.each do |channel|
          expect(channel["is_channel"]).must_equal true
        end
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        url = "https://slack.com/api/channels.list"
        key = ENV["SLACK_API_TOKEN"]
        channels_list = SlackApi::Channel.channel_api(url, key)

        expect(channels_list.first["name"]).must_equal "general"
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        url = "https://slack.com/api/channels.list"
        key = ENV["SLACK_API_TOKEN"]
        channels_list = SlackApi::Channel.channel_api(url, key)

        expect(channels_list.first["id"]).must_equal "CH2RC3CNQ"
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        url = "https://slack.com/api/channels.list"
        key = ENV["SLACK_API_TOKEN"]
        channels_list = SlackApi::Channel.channel_api(url, key)

        expect(channels_list.first["topic"]["value"]).must_equal "Company-wide announcements and work-based matters"
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        url = "https://slack.com/api/channels.list"
        key = ENV["SLACK_API_TOKEN"]
        channels_list = SlackApi::Channel.channel_api(url, key)

        expect(channels_list.first["num_members"]).must_equal 2
      end
    end

    it "channels list will only include existent channels " do
      VCR.use_cassette("slack_channels_json") do
        url = "https://slack.com/api/channels.list"
        key = ENV["SLACK_API_TOKEN"]
        channels_list = SlackApi::Channel.channel_api(url, key)

        channels_list.each do |channel|
          name = "Not a Channel"
          expect(channel["name"]).wont_equal name
        end
      end
    end

    it "raises error when a bad API call is made" do
      VCR.use_cassette("slack_channels_list") do
        url = "https://slack.com/api/channels.list"

        expect { SlackApi::Channel.channel_api(url, "") }.must_raise SlackApi::SlackError
      end
    end
  end

  describe "list channels" do
    it "returns an array" do
      VCR.use_cassette("slack_channels_list") do
        url = "https://slack.com/api/channels.list"
        key = ENV["SLACK_API_TOKEN"]
        channels_list = SlackApi::Channel.channel_api(url, key)

        expect(SlackApi::Channel.list(channels_list)).must_be_instance_of Array
      end
    end
  end
end

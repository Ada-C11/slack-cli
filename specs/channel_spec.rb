require_relative "test_helper"

describe SlackApi::Channel do
  describe "json channels" do
    it "returns valid channels" do
      VCR.use_cassette("slack_channels_json") do
        channels_list = SlackApi::Channel.channel_api

        channels_list.each do |channel|
          expect(channel["is_channel"]).must_equal true
        end
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        channels_list = SlackApi::Channel.channel_api

        expect(channels_list.first["name"]).must_equal "general"
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        channels_list = SlackApi::Channel.channel_api

        expect(channels_list.first["id"]).must_equal "CH2RC3CNQ"
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        channels_list = SlackApi::Channel.channel_api

        expect(channels_list.first["topic"]["value"]).must_equal "Company-wide announcements and work-based matters"
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_json") do
        channels_list = SlackApi::Channel.channel_api

        expect(channels_list.first["num_members"]).must_equal 2
      end
    end

    it "channels list will only include existent channels " do
      VCR.use_cassette("slack_channels_json") do
        channels_list = SlackApi::Channel.channel_api

        channels_list.each do |channel|
          name = "Not a Channel"
          expect(channel["name"]).wont_equal name
        end
      end
    end
    # it "returns info with a valid token" do
    #   VCR.use_cassette("slack_channels_list") do
    #     channels_list = SlackApi::Channel.channel_api

    #     expect(channels_list["ok"]).must_equal true
    #   end
    # end
  end
  describe "list channels" do
    it "returns an array" do
      VCR.use_cassette("slack_channels_list") do
        channels_list = SlackApi::Channel.channel_api
        expect(SlackApi::Channel.list(channels_list)).must_be_instance_of Array
      end
    end
  end
end

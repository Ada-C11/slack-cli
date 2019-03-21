require_relative "test_helper"

describe SlackApi::Channel do
  describe "list channels" do
    it "returns valid channels" do
      VCR.use_cassette("slack_channels_list") do
        channels_list = SlackApi::Channel.channel_api

        channels_list.each do |channel|
          expect(channel["is_channel"]).must_equal true
        end
      end
    end

    it "return includes a specific channel" do
      VCR.use_cassette("slack_channels_list") do
        channels_list = SlackApi::Channel.channel_api

        expect(channels_list.first["name"]).must_equal "general"
      end
    end

    it "channels list will only include existent channels " do
      VCR.use_cassette("slack_channels_list") do
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
end

#0. make sure that what's being returned is in the format we want (i.e. a hash or array)

#1. make sure that what is returned are actual channels
# expect(channels.list) includes "general"

#2. make sure that the right things are being returned for each users
# expect { one component of generals's user info is } channel name
# expect { one component of generals's user info is } slack_id
# expect { one component of generals's user info is } topic
# expect { one component of generals's user info is } user count

#3. expect if there are NO channels -> return empty array

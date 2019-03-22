require_relative "test_helper"

describe "Channel" do
  let (:channel_data) do
    {
      id: "CH2P2QWMR",
      channel_name: "People Wearing Hats",
      topic: "Things of interest to people wearing hats.",
      members: 2
    }
  end
  it "instantiates a channel object" do
    new_channel = SlackCLI::Channel.new(
      channel_data[:id],
      channel_data[:channel_name],
      channel_data[:topic],
      channel_data[:members]
    )

    expect(new_channel).must_be_instance_of SlackCLI::Channel
  end

  it "has working reader methods" do
    new_channel = SlackCLI::Channel.new(
      channel_data[:id],
      channel_data[:channel_name],
      channel_data[:topic],
      channel_data[:members]
    )

    expect(new_channel.id).must_equal channel_data[:id]
    expect(new_channel.name).must_equal channel_data[:channel_name]
    expect(new_channel.topic).must_equal channel_data[:topic]
    expect(new_channel.members).must_equal channel_data[:members]
  end

  it "loads arrays of channels from Slack's API" do
    VCR.use_cassette("list_channels") do
      param = ENV["SLACK_API_TOKEN"]
      channels = SlackCLI::Channel.list("https://slack.com/api/channels.list", param)
      expect(channels).must_be_instance_of Array
      channels.each do |channel|
        expect(channel).must_be_instance_of SlackCLI::Channel
      end
    end
  end
end

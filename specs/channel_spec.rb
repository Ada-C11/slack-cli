require_relative 'test_helper'

describe "Channel" do
  let (:channel_data) {
    {
      id: "CH2P2QWMR", 
      channel_name: "everyone", 
      topic:{"value"=>"Company-wide announcements and work-based matters", 
        "creator"=>"UH36TMYKF", 
        "last_set"=>1552952569}, 
      members: 2
    }
  }
  it "instantiate a channel object" do
    VCR.use_cassette("slack_channels") do
       
      new_channel = SlackCLI::Channel.new(
        channel_data[:id],
        channel_data[:channel_name],
        channel_data[:topic],
        channel_data[:members]
      )

      expect(new_channel).must_be_instance of Channel
    end
  end  

  it "has working reader methods" do
    new_channel = SlackCLI::Channel.new(
      channel_data[:id],
      channel_data[:channel_name],
      channel_data[:topic],
      channel_data[:members]
    )

    expect(new_channel.id).must_equal channel_data[:id]
    expect(new_channel.channel_name).must_equal channel_data[:channel_name]
    expect(new_channel.topic).must_equal channel_data[:topic]
    expect(new_channel.members).must_equal channel_data[:members]
  end

  it "loads array of channels from Slack's API" do
    VCR.use_cassette("list_channels") do
      channels = SlackCLI::Channel.get_from_api
      expect(channels).must_be_instance_of Array
      channels.each do |channel|
        expect(channel).must_be_instance_of SlackCLI::Channel
      end
    end
  end   
end
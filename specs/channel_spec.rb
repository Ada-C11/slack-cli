require_relative "test_helper"

describe "Channel" do
  let(:get_response) do
    VCR.use_cassette("slack/get") { SlackCli::Channel.get }
  end
  let(:channel_list) do
    VCR.use_cassette("slack/list") { SlackCli::Channel.list }
  end

  describe "self get method" do
    it "successfully returns an HTTP response object" do
      channels = get_response

      expect(channels["ok"]).must_equal true
    end
  end
  describe "list" do
    it "creates a list of all channels" do
      channels = channel_list

      expect(channels).must_be_kind_of Array
      channels.each do |channel|
        expect(channel).must_be_instance_of SlackCli::Channel
      end
    end

    it "returns nil for a channel that doesn't exist" do
    end
  end

  describe "details" do
    channels = channel_list
    it "lists details for an instance of channel" do
      channel_deets = channels[1].details

      expect(channel_deets).must_equal channels[1].details
    end
  end
end

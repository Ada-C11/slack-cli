require_relative "test_helper"

describe "Channel" do
  let(:get_response) do
    VCR.use_cassette("slack/channel_get") { SlackCli::Channel.get }
  end
  let(:channel_list) do
    VCR.use_cassette("slack/channel_list") { SlackCli::Channel.list }
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
  end

  describe "details" do
    it "lists details for an instance of channel" do
      channels = channel_list
      expect(channels[1].details).must_be_kind_of String
    end
  end
end

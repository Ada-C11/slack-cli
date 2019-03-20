require_relative "test_helper"

describe "Channel" do
  describe "self get method" do
    it "successfully returns users list HTTP response object" do
      VCR.use_cassette("get_response") do
        channels = Channel.get

        expect(channels["ok"]).must_equal true
      end
    end

    it "raises SlackError for for bad request" do
      # VCR.use_cassette("get_response") do
      # end
    end
  end
  describe "list" do
    it "creates a list of all channels" do
      VCR.use_cassette("get_response") do
        channels = Channel.list

        expect(channels).must_be_kind_of Array
        expect(channels.first).must_be_instance_of Channel
        expect(channels.last).must_be_instance_of Channel
      end
    end
  end

  describe "details" do
    it "lists details for an instance of channel" do
      VCR.use_cassette("get_response") do
        channels = Channel.list
        channel_deets = channels[1].details

        expect(channel_deets).must_equal channels[1].details
      end
    end
  end
end

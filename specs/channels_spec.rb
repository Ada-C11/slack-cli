require_relative "test_helper"

describe "Channels" do
  describe "self.get" do
    it "will successfully get a response from Slack API for user list" do
      VCR.use_cassette("channel_information_find") do
        url = "http://slack.com/api/channels.list"
        query = {token: ENV["KEY"]}
        request = Slack::Channel.get(url, query)

        expect(request["ok"]).must_equal true
      end
    end

    it "will raise an exception if the GET request fails" do
      VCR.use_cassette("channel_information_find") do
        url = "https://slack.com/api/channel.list"
        query = {token: "dkdkdkdkdkdkd"}

        expect {
          Slack::Channel.get(url, query)
        }.must_raise Slack::ResponseError
      end
    end
  end
end

describe "Self.list" do
  it "return an array of channels" do
    VCR.use_cassette("channel_information_find") do
      channels = Slack::Channel.list

      expect(channels).must_be_kind_of Array

      (0..channels.length - 1).each do |i|
        expect(channels[i]).must_be_kind_of Slack::Channel
      end
    end

    describe "#details" do
      it "must return an array that contains the correct strings" do
        channel = Slack::Channel.new("potato", "head", "toy", "story")
        expect(channel.details).must_be_kind_of Array
        expect(channel.details[0]).must_equal "name"
        expect(channel.details[1]).must_equal "slack_id"
        expect(channel.details[2]).must_equal "topic"
        expect(channel.details[3]).must_equal "member_count"
      end
    end
    # # end end
  end
end

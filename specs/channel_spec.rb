require_relative "test_helper"

describe "Channels" do
  describe "self get method" do
    it "returns a response from api for channels list" do
      VCR.use_cassette("connect to channel api") do
        url = "http://slack.com/api/channels.list"
        query = { token: ENV["SLACK_API_TOKEN"] }
        request = Slack::Channel.get(url, query)
        # puts "BBBBBREQUESTBBBBBBBBBB"
        # puts "#{request}"
        expect(request["ok"]).must_equal true
      end
    end
  end

  it "raises exception if get request fails" do
    VCR.use_cassette("connect to channel api") do
      url = "https://slack.com/api/channel.list"
      query = { token: "idontworkidontworkkkkkk" }

      expect {
        Slack::Channel.get(url, query)
      }.must_raise Slack::ResponseError
    end
  end

  describe "self list method" do
    it "returns channels array" do
      VCR.use_cassette("connect to channel api") do
        channels = Slack::Channel.list
        expect(channels).must_be_kind_of Array

        (0..channels.length - 1).each do |i|
          expect(channels[i]).must_be_kind_of Slack::Channel
        end
      end

      describe "channel details method" do
        it "returns an array that contains correct strings" do
          channel = Slack::Channel.new("i", "play", "electric", "bass")
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
end

require_relative "test_helper"

describe "Channel" do
  describe "self.list" do
    before do
      VCR.use_cassette("make channels") do
        query_params = {
          token: KEY,
        }
        @channels = Slack::Channel.list
      end
    end

    it "will return an array of Channels" do
      expect(@channels).must_be_kind_of Array
      expect(@channels[0]).must_be_kind_of Slack::Channel
    end

    it "will assign the correct attributes to each Channel" do
      channel = @channels[0]
      expect(channel.slack_id).must_equal "CH2V3FHEY"
      expect(channel.name).must_equal "general"
      expect(channel.topic).must_equal "Company-wide announcements and work-based matters"
      expect(channel.member_count).must_equal 2
    end
  end
end

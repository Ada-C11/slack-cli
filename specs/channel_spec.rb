require_relative "test_helper"

describe "Channel" do
  describe "self.list" do
    before do
      VCR.use_cassette("make channels list") do
        query_params = {
          token: KEY,
        }
        @channels = Slack::Channel.list
        @channel = @channels.first
      end
    end

    it "will return an array of Channels" do
      expect(@channels).must_be_kind_of Array
      expect(@channel).must_be_kind_of Slack::Channel
    end

    it "will assign the correct attributes to each Channel" do
      expect(@channel.slack_id).must_equal "CH2V3FHEY"
      expect(@channel.name).must_equal "general"
      expect(@channel.topic).must_equal "Company-wide announcements and work-based matters"
      expect(@channel.member_count).must_equal 2
    end

    it "has the correct data tyes for each attribute" do
      expect(@channel.slack_id).must_be_kind_of String
      expect(@channel.name).must_be_kind_of String
      expect(@channel.topic).must_be_kind_of String
      expect(@channel.member_count).must_be_kind_of Integer
    end
  end

  describe "details" do
    before do
      VCR.use_cassette("show channel details") do
        query_params = {
          token: KEY,
        }
        @channels = Slack::Channel.list
        @channel = @channels.first
      end
    end

    it "returns the correct data" do
      details = @channel.details
      expected_details = {
        slack_id: @channel.slack_id,
        name: @channel.name,
        topic: @channel.topic,
        member_count: @channel.member_count,
      }

      expect(details).must_equal expected_details
    end
  end
end

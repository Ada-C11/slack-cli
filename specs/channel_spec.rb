require_relative "test_helper"

describe "Channel" do
  describe "Initialization" do
    let(:slack_id) { 20 }
    let(:channelname) { "everyone" }
    let(:topic) { "Slack API" }
    let(:member_count) { 2 }

    it "can be instantiated" do
      channel = Slack::Channel.new(slack_id, channelname, topic, member_count)
      expect(channel).must_be_instance_of Slack::Channel
      expect(channel.slack_id).must_equal 20
      expect(channel.name).must_equal "everyone"
      expect(channel.topic).must_equal "Slack API"
      expect(channel.member_count).must_equal 2
    end
  end
end

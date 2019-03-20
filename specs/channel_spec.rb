require_relative 'test_helper.rb'

describe "Channel class" do
  describe "Channel#initialize" do
    let(:channel) {
      Slack::Channel.new(id: "CBD", name: "general", topic: "stuff", member_count: "4")
    }
    it "returns an instance of Channel and a kind of Recipient" do
      expect(channel).must_be_instance_of Slack::Channel
      expect(channel).must_be_kind_of Slack::Recipient
    end
  end
end
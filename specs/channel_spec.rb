require_relative "test_helper.rb"

describe "Channel class" do
  let(:channel) {
    Slack::Channel.new(id: "CBD", name: "general", topic: "stuff", member_count: "4")
  }
  
  describe "Channel#initialize" do
    it "returns an instance of Channel and a kind of Recipient" do
      expect(channel).must_be_instance_of Slack::Channel
      expect(channel).must_be_kind_of Slack::Recipient
    end

    it "Checks instance variable name, id, topic, member_count: respond & equal to" do
      expect(channel).must_respond_to :name
      expect(channel).must_respond_to :id
      expect(channel).must_respond_to :topic
      expect(channel).must_respond_to :member_count

      expect(channel.name).must_equal "general"
      expect(channel.id).must_equal "CBD"
      expect(channel.topic).must_equal "stuff"
      expect(channel.member_count).must_equal "4"
    end
  end

  describe "Channel#details" do
    it "returns a String" do
      expect(channel.details).must_be_instance_of String
    end
  end
end

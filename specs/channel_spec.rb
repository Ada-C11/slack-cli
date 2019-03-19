require_relative "test_helper"

describe SlackCLI::Channel do
  describe "constructor" do
    before do
      @slack_id = "CH2SKTDBN"
      @name = "Catssss"
      @topic = "It's about cats, duh"
      @member_count = "2,000,000"
      @record = SlackCLI::User.new(slack_id: @slack_id, name: @name, topic: @topic, member_count: member_count)
    end

    it "is an instance of Channel" do
      expect(@record).must_be_kind_of SlackCLI::Channel
    end

    it "takes and saves a Slack id, name, topic, and member count" do
      expect(@record.slack_id).must_equal @slack_id
      expect(@record.name).must_equal @name
      expect(@record.topic).must_equal @topic
      expect(@record.member_count).must_equal @member_count
    end
  end
end

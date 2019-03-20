require_relative "test_helper"

describe SlackCLI::Channel do
  describe "constructor" do
    before do
      @slack_id = "CH2SKTDBN"
      @name = "Catssss"
      @topic = "It's about cats, duh"
      @member_count = "2,000,000"
      @record = SlackCLI::Channel.new(slack_id: @slack_id, name: @name, topic: @topic, member_count: @member_count)
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

  describe "self.list" do
    it "returns an array of channels" do
      VCR.use_cassette("channels find") do
        channels_array = SlackCLI::Channel.list

        expect(channels_array).must_be_kind_of Array
        expect(channels_array.first).must_be_kind_of SlackCLI::Channel
        expect(channels_array.length).wont_equal 0
      end
    end
  end

  describe "details" do
    before do
      @slack_id = "CH2SKTDBN"
      @name = "Catssss"
      @topic = "It's about cats, duh"
      @member_count = "2,000,000"
      @record = SlackCLI::Channel.new(slack_id: @slack_id, name: @name, topic: @topic, member_count: @member_count)
    end

    it "returns a string" do
      expect(@detail).must_be_kind_of String
    end

    it "returns the correct information" do
      expect(@detail).must_equal "Slack ID: #{@slack_id}, Name: #{@name}, Topic: #{@topic}, Member count: #{@member_count}"
    end
  end
end

require 'minitest'
require_relative 'test_helper.rb'

describe "Channel" do
  before do
    VCR.use_cassette("channel_list") do
      @response = SlackAPI::Channel.load
    end
  end

  describe "details" do

  end

  describe "self.list" do
    it "can list details of all the channels" do
      expect(SlackAPI::Channel.list).must_be_kind_of Array
    end
  end

  describe "self.load" do
    it "can find the list of channels" do
      expect(@response).must_be_kind_of Array
      expect(@response[0]).must_be_kind_of SlackAPI::Channel
      expect(@response[0].name).must_equal "everyone"
      expect(@response[0].slack_id).must_equal "CH2SBU69Y"
      expect(@response[0].topic).must_equal "Company-wide announcements and work-based matters"
      expect(@response[0].member_count).must_equal 2
    end
  end

    it "sends a message to selected channel" do
      VCR.use_cassette("channel_send_message") do
        channel = SlackAPI::Channel.list[0]
        test2 = channel.send_message(text: "hello")
        expect(test2).must_equal true
       end
    end

end
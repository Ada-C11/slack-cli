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
      #expect(response.length).must_equal 3
      expect(@response[0]).must_be_kind_of SlackAPI::Channel
      expect(@response[0].name).must_equal "everyone"
      expect(@response[0].slack_id).must_equal "CH2SBU69Y"
      expect(@response[0].topic).must_equal "Company-wide announcements and work-based matters"
      expect(@response[0].member_count).must_equal 2
    end
  end
end
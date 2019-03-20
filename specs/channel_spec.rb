require_relative "test_helper"
require "pry"
describe "channel class" do
  describe "initialize" do
    it "creates and instance of channel" do
      topic = "random"
      member_count = 3
      name = "cyndilopez6"
      slack_id = 1
      expect(Channel.new(name: name, slack_id: slack_id, topic: topic, member_count: member_count)).must_be_kind_of Channel
    end
  end

  describe "can connect to API" do
    before do
      VCR.use_cassette("connect to endpoints channels_list") do
        endpoint = "channels.list"
        @response = Channel.get(endpoint)
      end
    end

    it "accesses api" do
      expect(@response.code == 200 && @response.parsed_response["ok"]).must_equal true
    end
  end

  describe "creates list of channels" do
    # before do
    #   VCR.use_cassette("connect to endpoints channels_list") do
    #     endpoint = "channels.list"
    #     @response = Channel.get(endpoint)
    #   end
    # end

    it "returns a type of array" do
      VCR.use_cassette("returns array") do
        expect(Channel.list.is_a? Array).must_equal true
      end
    end

    it "returns an array of Channel objects" do
      VCR.use_cassette("returns object Channel") do
        expect(Channel.list[0]).must_be_kind_of Channel
      end
    end

    it "returns an accurate list of channels in slack workspace" do
      VCR.use_cassette("correct channels") do
        expect(Channel.list.map { |channel| channel.name }).must_equal ["general", "api-project", "random"]
      end
    end
  end
end

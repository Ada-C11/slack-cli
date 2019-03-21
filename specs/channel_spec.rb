require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/channel.rb"

describe "Channel class" do
  before do
    VCR.use_cassette("channel_list") do
      query_params = { token: ENV["SLACK_API_TOKEN"] }
      @response = Slack::Channel.list
    end
  end

  it "can retrieve a list of channels" do
    expect(@response).must_be_kind_of Array
    expect(@response[0]).must_be_kind_of Slack::Channel
    expect(@response[0].member_count).must_be_kind_of Integer
  end

  it "can retrieve details of a specific channel" do
    expect (@response[0].details).must_be_kind_of String
  end

  describe "send_message to channel" do
    it "can send a message fine" do
      VCR.use_cassette("slack_posts") do
        response = Slack::Channel.send_message("This is our Test Post!", "Slack-cli")
        expect(response).must_equal true
      end
    end

    it "will raise an error when given an invalid channel" do
      VCR.use_cassette("slack-posts") do
        exception = expect {
          Slack::Channel.send_message("This post should not work", "invalid-channel")
        }.must_raise Slack::SlackApiError
  
        expect(exception.message).must_equal 'channel_not_found'
      end
    end
  end
end

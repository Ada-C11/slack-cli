require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/channel.rb"

describe "Channel class" do
  before do
    VCR.use_cassette("channel_list") do
      @response = Channel.get_channels
    end
  end

  it "can retrieve a list of channels" do
    expect(@response).must_be_kind_of Array
    expect(@response[0]).must_be_kind_of Hash
    expect(@response[0]["members"].length).must_be_kind_of Integer
  end
end

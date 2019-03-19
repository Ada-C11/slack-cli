require_relative "test_helper.rb"
require "pry"

describe "Channel class" do
  it "Creates an instance of the Channel class" do
    new_channel = Slack::Channel.new("id", "name")
    expect(new_channel).must_be_instance_of Slack::Channel
  end
end

describe "List_all method" do
  it "Successfully GETs response from Slack API" do
    VCR.use_cassette("location_find") do
      response = Slack::Channel.get

      expect(response["ok"]).must_equal true
    end
  end
end

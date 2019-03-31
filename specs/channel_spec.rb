require_relative "test_helper"
require "pry"

describe "Channel class" do
  describe "Channel#initialize" do
    it "initializes a Channel object" do
      VCR.use_cassette("Channel") do
        response = Channel.new("fur_babes", "1234", "pets", ["AUAIWFS"])
        expect(response).must_be_instance_of Channel
      end
    end
  end

  describe "Channel#get" do
    it "returns information from the API" do
      VCR.use_cassette("Channel") do
        response = Channel.get
        expect(response["ok"]).must_equal true
      end
    end
  end

  describe "Channel#list" do
    it "includes a known channel" do
      VCR.use_cassette("Channel") do
        response = Channel.list
        expect(response[0]).must_be_instance_of Channel
        expect(response[0].member_count).must_be_instance_of Integer
      end
    end

    it "returns correct number of channels" do
      VCR.use_cassette("Channel") do
        response = Channel.list.length
        expect(response).must_equal 3
      end
    end
  end
end

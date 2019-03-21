require_relative "test_helper"

describe "Channel class" do
  describe "Channel#initialize" do
    it "initializes a Channel object" do
      VCR.use_cassette("Channel") do
        response = Channel.new
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
        expect(response).must_include "general"
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

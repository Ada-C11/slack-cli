require_relative "test_helper"
require "pry"
describe "returning channel lists" do
  it "API returns as a hash and its channel returns as an array" do
    VCR.use_cassette("slack_channels") do
      Channel.new

      expect(Channel.list).must_be_kind_of Array
      expect(Channel.list.first).must_be_kind_of Array
    end
  end

  it "make sure there are 3 member count in the list" do
    VCR.use_cassette("slack_channels") do
      Channel.new

      expect(Channel.list.length).must_equal 3
    end
  end

  it "lists correct Channel name" do
    VCR.use_cassette("slack_channels") do
      Channel.new

      expect(Channel.list[0][0]).must_equal "everyone"
    end
  end
end

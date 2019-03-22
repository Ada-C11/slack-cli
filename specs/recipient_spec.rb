require 'minitest'
require_relative 'test_helper.rb'

describe "Recipient" do
  before do

  end

  describe "send message" do
    it "sends a message to selected user" do
      VCR.use_cassette("send_message_to_user") do
        user = SlackAPI::User.list[0]
        test = user.send_message(text: "hello")
        expect(test).must_equal true
       end
    end

    it "sends a message to selected channel" do
      VCR.use_cassette("send_message_to_channel") do
        channel = SlackAPI::Channel.list[0]
        test2 = channel.send_message(text: "hello")
        expect(test2).must_equal true
       end
    end
  end

  describe "self.get" do
    
  end

  describe "details" do

  end

  describe "self.list" do
    
  end
end
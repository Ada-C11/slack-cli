require 'minitest'
require_relative 'test_helper.rb'

describe "User" do
  before do 
    VCR.use_cassette("load_users") do
      @response = SlackAPI::User.load
    end
  end

  describe "self.load" do
    it "can find the list of users" do
          expect(@response).must_be_kind_of Array
          expect(@response[0]).must_be_kind_of SlackAPI::User
          expect(@response[0].name).must_equal "slackbot"
          expect(@response[0].real_name).must_equal "Slackbot"
          expect(@response[0].slack_id).must_equal "USLACKBOT"
      end
  end

  describe "self.list" do
    it "prints out a table of users" do
          expect(SlackAPI::User.list).must_be_kind_of Array
         end
      end

  end

  describe "send message" do

    it "sends a message to selected user" do
      VCR.use_cassette("send_message") do
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



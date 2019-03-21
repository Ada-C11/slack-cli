require 'minitest'
require_relative 'test_helper.rb'

describe "User" do

  describe "self.load" do
    it "can find the list of users" do
        VCR.use_cassette("load_users") do
          response = SlackAPI::User.load
          expect(response).must_be_kind_of Array
          expect(response[0]).must_be_kind_of SlackAPI::User
          expect(response[0].name).must_equal "slackbot"
          expect(response[0].real_name).must_equal "Slackbot"
          expect(response[0].slack_id).must_equal "USLACKBOT"
         end
      end
  end

  describe "self.list" do
    it "prints out a table of users" do
          expect(SlackAPI::User.list).must_be_kind_of Array
         end
      end

  end



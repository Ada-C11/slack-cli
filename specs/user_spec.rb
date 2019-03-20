require 'minitest'
require_relative 'test_helper.rb'

describe "User" do

  describe "self.list" do
    it "can find the list of users" do
        VCR.use_cassette("user_list") do
          response = SlackAPI::User.list
          expect(response).must_be_kind_of Array
          expect(response[0]).must_be_kind_of SlackAPI::User
          expect(response[0].name).must_equal "slackbot"
          expect(response[0].real_name).must_equal "Slackbot"
          expect(response[0].slack_id).must_equal "USLACKBOT"
         end
      end
  end



end
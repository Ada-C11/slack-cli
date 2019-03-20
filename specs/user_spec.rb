require_relative "test_helper"

describe "user" do
  describe "self.list" do
    it "Returns an array of hashes" do
      VCR.use_cassette("self.list") do
        user_list = SlackBot::User.list

        expect(user_list).must_be_kind_of Array
        expect(user_list.first).must_be_kind_of Hash
        expect(user_list.first).must_be_kind_of Hash
      end
    end
    it "Returns a real_name" do
        VCR.use_cassette("self.list") do
            user_list = SlackBot::User.list

        expect(user_list.first[:real_name]).must_equal "Slackbot" 
        expect(user_list.first[:id]).must_equal "USLACKBOT"
        expect(user_list.first[:name]).must_equal "slackbot"
        end
    end
    # it "will raise an error when given an invalid token" do
    #     VCR.use_cassette("self.list") do
    #       exception = expect {
    #        SlackBot::User.list()
    #       }.must_raise SlackApi::SlackApiError
    
    #       expect(exception.message).must_equal 'channel_not_found'
    #     end
    #   end

  end
end

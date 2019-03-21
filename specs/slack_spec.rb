require_relative "test_helper"
# require_relative "slack"
# require_relative "spec_helper"
require "pry"

describe "Slack" do
  describe "list users and channels" do
    it "show a list of users" do
      VCR.use_cassette("slack_query") do # <-- .yml filename
        return_value = Slack.new
        # binding.pry
        expect(return_value).must_be_kind_of Slack
        expect(return_value.channels["channels"][0]["id"]).must_equal "CH41RMLP4"
        expect(return_value.users["members"][1]["name"]).must_equal "cello.elle"
      end
    end
  end

  describe "select users and channels" do
    it "select a user" do
      VCR.use_cassette("slack_query") do # <-- .yml filename
        user_a = user.select("UH53ZCBBR") # <-- this is "id" value for "kaseea"
        user_b = user.select("kaseea") # <-- this is "name" value for "kaseea"

        expect(user_a).must_equal "UH53ZCBBR"
        expect(user_b).must_equal "kaseea"
      end
    end

    it "select a channel" do
      VCR.use_cassette("slack_query") do # <-- .yml filename
        channel_a = channel.select("apiiiii:")
        channel_b = channel.select("CH53ZCWDV") # <-- this is the "id" value for the general channel
        expect(channel_a).must_equal "apiiiii"
        expect(channel_a).must_equal "CH53ZCWDV"
      end
    end

    it "select a channel" do
      VCR.use_cassette("slack_query") do
        # TEST GOES HERE
      end
    end

    it "select a channel" do
      VCR.use_cassette("slack_query") do
        # TEST GOES HERE
      end
    end

    it "select a channel" do
      VCR.use_cassette("slack_query") do
        # TEST GOES HERE
      end
    end
    #
  end

  #   describe "send_msg" do
  #     it "can send a valid message" do
  #       VCR.use_cassette("slack_query") do
  #         return_value = SlackApi.send_msg("Test message",
  #                                          "ports-api-testing")

  #         expect(return_value).must_equal true
  #       end
  #     end

  #     it "generates an error if given an invalid channel" do
  #       VCR.use_cassette("slack_query") do
  #         expect {
  #           SlackApi.send_msg("Test message",
  #                             "bogus")
  #         }.must_raise SlackApi::SlackError
  #       end
  #     end
  #     it "will generate an error if given an invalid key" do
  #       real_token = ENV["SLACK_TOKEN"]
  #       ENV["SLACK_TOKEN"] = "NOT_REAL_TOKEN"

  #       VCR.use_cassette("slack_query") do
  #         error = expect {
  #           SlackApi.send_msg("Test message with invalid key",
  #                             "ports-api-testing")
  #         }.must_raise SlackApi::SlackError
  #         expect(error.message).must_equal "Error when posting Test message with invalid key to ports-api-testing, error: invalid_auth"
  #       end

  #       ENV["SLACK_TOKEN"] = real_token
  #     end

  #     it "will raise an error if given an empty message" do
  #       VCR.use_cassette("slack_query") do
  #         error = expect {
  #           SlackApi.send_msg("",
  #                             "ports-api-testing")
  #         }.must_raise SlackApi::SlackError

  #         expect(error.message).must_equal "Error when posting  to ports-api-testing, error: no_text"
  #       end
  #     end
  #   end
end

# ----------------------------------------------------------

# describe "SlackAPI" do
#   it "can send a valid message" do
#     VCR.use_cassette("slack_query") do
#       location = "Seattle"
#       response = get_location(location)

#       expect(response["Seattle"]).wont_be_nil
#       expect(response["Seattle"][:lon]).must_equal "-122.3300624"
#       expect(response["Seattle"][:lat]).must_equal "47.6038321"
#     end
#   end

#   it "will raise an exception if the search fails" do
#     VCR.use_cassette("location_find") do
#       location = ""
#       expect {
#         response = get_location(location)
#       }.must_raise SearchError
#     end
#   end
# end

# ----------------------------------------------------------

# describe "Listing Channels and Users" do
#   it "list channels" do
#     VCR.use_cassette("channels_find") do
#       location = "Seattle"
#       response = get_location(location)

#       expect(response["Seattle"]).wont_be_nil
#       expect(response["Seattle"][:lon]).must_equal "-122.3300624"
#       expect(response["Seattle"][:lat]).must_equal "47.6038321"
#     end
#   end

#   it "list users" do
#     VCR.use_cassette("location_find") do
#       user = "" # name parameter in slack api
#       expect {
#         response = get_location(location)
#       }.must_raise SearchError
#     end
#   end
# end

require_relative "test_helper"
require "pry"

#potential tests
#make sure main method makes a new slack?

describe "Slack" do
  describe "list users and channels" do
    it "show a list of users" do
      VCR.use_cassette("slack_query") do # <-- .yml filename
        return_value = Slack.new
        expect(return_value).must_be_kind_of Slack
        expect(return_value.channels[0].slack_id).must_equal "CH41RMLP4"
        expect(return_value.users[1].user_name).must_equal "cello.elle"
      end
    end
  end

  describe "select users and channels" do
    it "select a user" do
      VCR.use_cassette("slack_query") do
        slack = Slack.new # <-- .yml filename
        user_a = slack.select_user("UH53ZCBBR") # <-- this is "id" value for "kaseea"
        user_b = slack.select_user("kaseea") # <-- this is "name" value for "kaseea"
        # binding.pry
        expect(user_a.user_id).must_equal "UH53ZCBBR"
        expect(user_b.user_name).must_equal "kaseea"
      end
    end

    it "select a channel" do
      VCR.use_cassette("slack_query") do # <-- .yml filename
        slack = Slack.new
        channel_a = slack.select_channel("apiiiii")
        channel_b = slack.select_channel("CH4BCTLHK") # <-- this is the "id" value for the general channel
        expect(channel_a.name).must_equal "apiiiii"
        expect(channel_b.name).must_equal "random"
      end
    end
  end

  describe "select users and channels" do
    it "does details" do
      VCR.use_cassette("slack_query") do
        slack = Slack.new
        channel_a = slack.select_channel("apiiiii")
        user_b = slack.select_user("kaseea")
        expect(channel_a).must_respond_to :details
        expect(user_b).must_respond_to :details
      end
    end

    #need a test for list channels
    #need a test for list users
    describe "send_msg" do
      it "can send a valid message" do
        VCR.use_cassette("slack_query") do
          to_send = Slack.send_msg("apiiiii", "sup?")
          expect(to_send).must_equal true
        end
      end
      it "generates an error if given an invalid channel" do
        VCR.use_cassette("slack_query") do
          expect {
            Slack.send_msg("bogus", "Test message")
          }.must_raise SlackError
        end
      end
      it "will generate an error if given an invalid key" do
        real_token = ENV["SLACK_TOKEN"]
        ENV["SLACK_TOKEN"] = "NOT_REAL_TOKEN"

        VCR.use_cassette("slack_query") do
          error = expect {
            Slack.send_msg("Test message with invalid key",
                           "apiiiii")
          }.must_raise SlackError
          # expect(error.message).must_equal "you suck"
        end

        ENV["SLACK_TOKEN"] = real_token
      end
    end
  end

  # it "select a channel" do
  #   VCR.use_cassette("slack_query") do
  #     # TEST GOES HERE
  #   end
  # end
  #

end

#

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
# end

# ----------------------------------------------------------
# it "raise an error if given a non-existant user or channel" do
#   VCR.use_cassette("slack_query") do
#     slack = Slack.new
#     expect do
#       slack.select_channel("Citris Fruit")
#     end.must_raise SlackError
#     expect do
#       slack.select_user("Pomolo")
#     end.must_raise SlackError
#   end
# end

# it "raise an error if no user is selected" do
#   VCR.use_cassette("slack_query") do
#     # TEST GOES HERE
#     slack = Slack.new
#     # expect(chosen_user).must_equal "" # <-- do we want this to be nil or ""?
#     expect { slack.select_user("") }.must_raise SlackError # <-- also, I think we need chosen_user to be an attr_reader, or break this part into a different method
#   end
# end

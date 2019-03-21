require_relative "test_helper"
require "pry"

describe SlackApi do
  # it "can send a valid message" do
  #   VCR.use_cassette("slack_message2") do
  #     # test_workspace = SlackApi::Workspace.new
  #     return_value = SlackApi.send_message("It's gonna work!",
  #                                          "marshallscm")

  #     expect(return_value).must_equal true
  #   end
  # end

  it "generates an error if given an invalid channel" do
    VCR.use_cassette("slack_message") do
      # return_value = SlackApi.send_message("Test message",
      #  "bogus")
      expect {
        SlackApi.send_message("Test message",
                              "bogus")
      }.must_raise SlackApi::SlackApiError
    end
  end

  it "will generate an error if given an invalid key" do
    VCR.use_cassette("slack_message") do
    end
  end
  it "will raise an error if given an empty message" do
    VCR.use_cassette("slack_message") do
    end
  end
end

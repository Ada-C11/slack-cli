require_relative "test_helper"
require 'pry'
USER_URL = "https://slack.com/api/users.list".freeze
CHANNEL_URL = "https://slack.com/api/channel.list".freeze

describe "Recipient Class" do
  before do
    @test = SlackCLI::Recipient.new("abc12whatever", "HiChris")
  end
  describe "Recipient initialization" do
    it "name returns as a string for user" do
      expect(@test.name).must_be_kind_of String
    end

    it "name returns correct string" do
      expect(@test.name).must_equal "HiChris"
    end

    it "id returns as a string for user" do
      expect(@test.id).must_be_kind_of String
    end

    it "id returns correct string" do
      expect(@test.id).must_equal "abc12whatever"
    end
  end

  # describe "self.get_response method" do
  #   it "creates it imports data as HTTParty class" do
  #     VCR.use_cassette("get_response") do
  #       user = USER_URL
  #       param = ENV["SLACK_API_TOKEN"]
  #       request_url = SlackCLI::Recipient.get
  #       expect(request_url).must_be_kind_of HTTParty::Response
  #     end
  #   end
  # end

  # describe "self.list method" do
  #   it "returns an array" do
  #     test_data = { "member" => [{ "name" => "Myriam", "real_name" => "Myriam Walden-Duarte", "id" => "himyriam" }, { "name" => "Kate", "real_name" => "Kate Sandler", "id" => "katekate" }, { "name" => "Slackbot", "real_name" => "Beep beep click zzzap.", "id" => "10110100" }] }
  #     # expect(SlackCLI::Recipient.list(test_data)).must_be_kind_of Array
  #     # # puts SlackCLI::Recipient.list(test_data)
  #   end
  # end
end

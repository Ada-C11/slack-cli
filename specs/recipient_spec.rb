require_relative "test_helper"
require "pry"
describe "recipient class" do
  describe "initialize" do
    it "creates an instance of Recipient" do
      #check slack_if format
      slack_id = 1
      name = "Maria"
      expect(Recipient.new(slack_id: slack_id, name: name)).must_be_kind_of Recipient
    end

    it "raises an argument error if name is not a string" do
      expect { Recipient.new(slack_id: 1, name: 21) }.must_raise ArgumentError
    end
  end

  describe "can connect to API" do
    it "can connect" do
      VCR.use_cassette("find channels") do
        BASE_URL = "https://slack.com/api/channels.list"
        params = {token: ENV["SLACK_API_TOKEN"]}
        response = Recipient.get(BASE_URL, params)
        expect(response["channels"]).wont_be_nil
        expect(response["channels"].map { |channel| channel["name"] }).must_equal ["general", "api-project", "random"]
      end
    end

    it "gives a list of two names" do
      VCR.use_cassette("find channels") do
        BASE_URL = "https://slack.com/api/users.list"
        params = {token: ENV["SLACK_API_TOKEN"]}
        response = Recipient.get(BASE_URL, params)
        Binding.pry
        expect(response["name"]).wont_be_nil
      end
    end
  end
end

require_relative "test_helper.rb"
require "pry"

describe "Channel class" do
  it "Creates an instance of the Channel class" do
    new_user = Slack::User.new("id", "name", "real name")
    expect(new_user).must_be_instance_of Slack::User
  end
end

describe "get method" do
  it "Successfully GETs response from Slack API" do
    VCR.use_cassette("user_find") do
      response = Slack::User.get
      expect(response["ok"]).must_equal true
    end
  end
end

describe "list_all method" do
  it "gives a list of all user information from the API" do
    VCR.use_cassette("user_find") do
      list_response = Slack::User.list_all
      ap list_response
      expect(list_response.length).must_equal 3
      expect(list_response[0].name).must_equal "slackbot"
    end
  end
end

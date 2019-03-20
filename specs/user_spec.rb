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
    VCR.use_cassette("location_find") do
      response = Slack::User.get

      expect(response["ok"]).must_equal true
    end
  end
end

# unsure what this test should result in. also, not sure calling the correct test
describe "list_all method" do
  it "gives a list of all user information from the API" do
    VCR.use_cassette("location_find") do
      list_response = Slack::User.list_all
      expect(list_response.first).must_equal "USLACKBOT"
    end
  end
end

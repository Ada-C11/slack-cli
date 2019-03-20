require_relative "test_helper"
require "pry"
describe "user class" do
  describe "initialize" do
    it "creates and instance of user" do
      real_name = "Maria Wissler"
      status_text = ""
      status_emoji = ""
      expect(User.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji)).must_be_kind_of User
    end
  end

  describe "can connect to API" do
    it "gives a list of three names" do
      VCR.use_cassette("find members") do
        endpoint = "users.list"
        response = User.get(endpoint)
        expect(response).wont_be_nil
        expect(response["members"].map { |member| member["name"] }).must_equal ["slackbot", "wmcarmelina", "cyndilopez6"]
      end
    end
    it "correctly finds the status of a member" do
      VCR.use_cassette("user status") do
        endpoint = "users.list"
        response = User.get(endpoint)
        expect(response["members"][0]["profile"]["status_text"].length).must_equal 0
        expect(response["members"].select { |member| member["real_name"] == "Maria Wissler" }[0]["profile"]["status_text"]).must_equal "Working remotely from Kauai"
      end
    end
    describe "create list of users" do
      it "returns an array with instance of user" do
        VCR.use_cassette("user status") do
          user_list = User.list
          expect(user_list).must_be_kind_of Array
        end
      end
    end
  end
end

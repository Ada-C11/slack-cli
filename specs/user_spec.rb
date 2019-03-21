require_relative "test_helper"
require "pry"
describe "user class" do
  describe "initialize" do
    it "creates and instance of user" do
      name = "mcarmelina"
      slack_id = 123
      real_name = "Maria Wissler"
      status_text = ""
      status_emoji = ""
      expect(User.new(name: name, slack_id: slack_id, real_name: real_name, status_text: status_text, status_emoji: status_emoji)).must_be_kind_of User
    end
  end

  describe "can connect to API" do
    before do
      VCR.use_cassette("connect to endpoints users_list") do
        endpoint = "users.list"
        @response = User.get(endpoint)
        expect(@response.code == 200 && @response.parsed_response["ok"]).must_equal true
      end
    end
    it "gives a list of names" do
      VCR.use_cassette("find members") do
        expect(@response).wont_be_nil
        expect(@response["members"].map { |member| member["name"] }.length).must_be :>, 0
      end
    end
    it "finds the status of a member" do
      VCR.use_cassette("user status") do
        expect(@response["members"][0]["profile"]["status_text"].length).wont_be_nil
      end
    end
  end

  describe "create list of users" do
    before do
      VCR.use_cassette("list_users") do
        @user_list = User.list
      end
    end
    it "returns an array of users" do
      VCR.use_cassette("list_users") do
        expect(@user_list).must_be_kind_of Array
      end
    end
    it "contains instances of user within the array" do
      VCR.use_cassette("instance of User within array") do
        expect(@user_list[0]).must_be_kind_of User
      end
    end
    # can this be used for other channel?
    it "returns a list with length 3" do
      VCR.use_cassette("length user list") do
        expect(@user_list.length).must_be :>, 0
      end
    end

    it "returns name of first user correctly" do
      VCR.use_cassette("length user list") do
        expect(@user_list.first.real_name).must_equal "Slackbot"
      end
    end
  end
end

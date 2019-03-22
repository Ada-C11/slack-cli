require_relative "test_helper"

describe "User Class" do
  describe "self.get" do
    it "sucessfully gets a response from Slack API for user list" do
      VCR.use_cassette("user_information_find") do
        url = "https://slack.com/api/users.list"
        query = {token: ENV["KEY"]}
        request = Slack::User.get(url, query)

        expect(request["ok"]).must_equal true
      end
    end

    it "will raise an exception if the GET request fails" do
      VCR.use_cassette("user_information_find") do
        url = "https://slack.com/api/users.list"
        query = {token: "dkdkdkdkdkdkd"}

        expect {
          Slack::User.get(url, query)
        }.must_raise Slack::ResponseError
      end
    end
  end

  describe "self.list" do
    it "returns an array that contains instances of users" do
      VCR.use_cassette("user_information_find") do
        users = Slack::User.list

        expect(users).must_be_kind_of Array
        (0..users.length - 1).each do |i|
          expect(users[i]).must_be_kind_of Slack::User
        end
      end
    end

    it "loads all user information correctly" do
      VCR.use_cassette("user_information_find") do
        users = Slack::User.list
        expect(users[1].name).must_equal "kimberly.fasbender"
        expect(users[1].real_name).must_equal "Kim Fasbender"
        expect(users[1].slack_id).must_equal "UH408BVL7"
        expect(users.length).must_equal 3
      end
    end

    describe "#details" do
      it "must return an array that contains the correct strings" do
        user = Slack::User.new("potato", "head", "toy")
        expect(user.details).must_be_kind_of Array
        expect(user.details[0]).must_equal "name"
        expect(user.details[1]).must_equal "slack_id"
        expect(user.details[2]).must_equal "real_name"
      end
    end
    # # end end
  end
end

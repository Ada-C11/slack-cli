require_relative "test_helper"

describe "User Class" do
  describe "self get method" do
    it "successfully connects to API" do
      VCR.use_cassette("connect to API") do
        url = "https://slack.com/api/users.list"
        query = {token: ENV["SLACK_API_TOKEN"]}
        request = Slack::User.get(url, query)

        expect(request["ok"]).must_equal(true)
      end
    end
  end

  it "raises and exception if API call fails" do
    VCR.use_cassette("api fail") do
      url = "https://slack.com/api/users.list"
      query = {token: "i love cats"}
      
      expect{Slack::User.get(url, query)}.must_raise(Slack::ResponseError)
    end
    
  end

  describe "self list method" do
    it "returns array with user instances" do
      VCR.use_cassette("connect to api") do
        user = Slack::User.list

        expect(user).must_be_kind_of(Array)
        # check at index that its an instance of user
      end
    end

    it "correctly loads user information" do
      VCR.use_cassette("connect to api") do
        users = Slack::User.list
        expect(users[1].name).must_equal "faiza.ahsan1222"
        expect(users[1].real_name).must_equal "Faiza Husain"
        expect(users[1].slack_id).must_equal "UH2NWFHTM"
        expect(users.length).must_equal 3
      end
    end

    describe "user details methods" do
      it "returns an array with correct string values" do
        user = Slack::User.new("I", "play", "bass")
        expect(user.details).must_be_kind_of Array
        expect(user.details[0]).must_equal "name"
        expect(user.details[1]).must_equal "slack_id"
        expect(user.details[2]).must_equal "real_name"
      end
    end

  end
end
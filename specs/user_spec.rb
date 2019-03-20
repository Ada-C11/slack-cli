require_relative "test_helper.rb"

describe "User child class" do
  describe "initialize" do
  end

  describe "user self.get method" do 
    it "successfully returns an HTTParty response object" do
      VCR.use_cassette("user_response") do 
        expect(SlackCli::User.get["ok"]).must_equal true
      end
    end
  end
  describe "user self.list method" do 
    it "creates a list of all user objects" do
      VCR.use_cassette("user_response") do 
        user_list = SlackCli::User.list

        expect(user_list).must_be_kind_of Array
        expect(user_list.first).must_be_instance_of SlackCli::User 
        expect(user_list.last).must_be_instance_of SlackCli::User
      end
    end

    it "returns nil for a user that doesn't exist" do 
    end
  end

  describe "user self.list_users method" do 
    it "returns all usernames in workspace in array" do
      VCR.use_cassette("user_response") do 
        expect(SlackCli::User.list_users).must_be_kind_of Array 
        expect(SlackCli::User.list_users.length).must_equal 3
      end
    end
  end
end
require_relative "test_helper.rb"

describe "User child class" do
  let(:get_response) do
    VCR.use_cassette("slack/user_get") { SlackCli::User.get }
  end
  let(:users_list) do
    VCR.use_cassette("slack/user_list") { SlackCli::User.list }
  end

  describe "user self.get method" do
    it "successfully returns an HTTParty response object" do
      users = get_response
      
      expect(users["ok"]).must_equal true
    end
  end

  describe "user self.list method" do
    it "creates a list of all user objects" do
      
      user_list = users_list

      expect(user_list).must_be_kind_of Array
      expect(user_list.first).must_be_instance_of SlackCli::User
      expect(user_list.last).must_be_instance_of SlackCli::User
    end
  end
end

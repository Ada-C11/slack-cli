require_relative 'test_helper'

BASE_URL = "https://slack.com/api/"
KEY = ENV["TOKEN"]
  
describe "User class" do
  describe "Get and List methods" do
    
    it "returns an array of users" do
      VCR.use_cassette("get-and-list") do 
        url = "#{BASE_URL}users.list"
        params =  {token: KEY}
        @users = User.get(url, params)
        
      expect(@users[1].real_name).must_equal "Karla Guadron"
      expect(@users.length).must_equal 3
      expect(@users).must_be_kind_of Array
      expect(@users[0].methods).must_include :real_name, :username
    end    
  end

    it "raises an error if code is not 200" do
      VCR.use_cassette("get-and-list") do
        params = {token: 1}
        expect {   
          User.get("#{BASE_URL}users.list", params)
        }.must_raise SlackApiError
      end
    end
 
  end
end  
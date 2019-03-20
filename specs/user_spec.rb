require_relative 'test_helper'

  BASE_URL = "https://slack.com/api/"
  KEY = ENV["TOKEN"]
describe "User class" do


  describe "Get and List methods" do
    
  #   it "can get all users in the workspace" do
  #     VCR.use_cassette("get-and-list") do 
  #       url = "#{BASE_URL}users.list"
  #       params =  {token: KEY}
  #       @users = User.get(url, params)
      
  #     expect(@users).must_be_kind_of HTTParty::Response
  #   end
    
  # end

    it "raises an error if code is not 200" do
      VCR.use_cassette("get-and-list") do
        params =  {token: 1}
        exception = expect {   
          User.get("#{BASE_URL}users.list", params)
        }.must_raise SlackApiError
      end
    end
 
  end
end
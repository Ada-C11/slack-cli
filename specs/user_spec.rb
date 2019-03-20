require 'minitest'
require_relative 'spec_helper.rb'

describe "User" do
  before do

  end

  describe "details" do

  end

  describe "self.list" do
    it "can find the list of users" do
      VCR.use_cassette("user_list") do
        location = "Seattle"
        response = get_location(location)
  
        expect(response).wont_be_nil
        expect(response["Seattle"][:lon]).must_equal "-122.3300624"
        expect(response["Seattle"][:lat]).must_equal "47.6038321"
      end
  end
end
require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/user.rb"

describe "User class" do
  before do
    VCR.use_cassette("user_list") do
      @response = User.get_users
    end
  end

  it "can retrieve a list of users" do
    expect(@response).must_be_kind_of Array
    expect(@response[0]).must_be_kind_of Hash
  end
end

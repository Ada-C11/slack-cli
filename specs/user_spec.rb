require_relative "test_helper"

describe "User class" do
  describe "User#initialize" do
    it "initializes a User object" do
      VCR.use_cassette("User") do
        response = User.new
        expect(response).must_be_instance_of User
      end
    end
  end
  describe "User#list" do
    it "includes a known User" do
      VCR.use_cassette("User") do
        response = User.list
        expect(response).must_include "ngocle"
      end
    end

    it "returns correct number of Users" do
      VCR.use_cassette("User") do
        response = User.list.length
        expect(response).must_equal 3
      end
    end

    # it "will raise an exception if the search fails" do
    #   VCR.use_cassette("User") do
    #     response = User.list
    #     expect { response }.must_raise ArgumentError
    #   end
    # end
  end
end

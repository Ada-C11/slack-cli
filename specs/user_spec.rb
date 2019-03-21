require_relative "test_helper"

describe "User class" do
  describe "User#initialize" do
    it "initializes a User object" do
      VCR.use_cassette("User") do
        response = User.new("Larry", "Truck", "1234")
        expect(response).must_be_instance_of User
      end
    end
  end

  describe "User#get" do
    it "returns information from the API" do
      VCR.use_cassette("User") do
        response = User.get
        expect(response["ok"]).must_equal true
      end
    end
  end

  describe "User#list" do
    it "includes a known User" do
      VCR.use_cassette("User") do
        response = User.list
        expect(response[0]).must_be_instance_of User
      end
    end

    it "User details are correct" do
      VCR.use_cassette("User") do
        response = User.list
        expect(response[1].username).must_equal "amyesh08"
      end
    end

    it "returns correct number of Users" do
      VCR.use_cassette("User") do
        response = User.list.length
        expect(response).must_equal 3
      end
    end
  end
end

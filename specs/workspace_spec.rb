require_relative "test_helper"
require "pry"

describe "Workspace class" do
  describe "Workspace#initialize" do
    it "initializes a Workspace object" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        #binding.pry
        expect(response).must_be_instance_of Workspace
      end
    end
  end

  describe "select_user" do
    it "selects a known user" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        response.select_user("ngocle")
        expect(response.selected[0]["name"]).must_equal "ngocle"
      end
    end

    it "raises an Argument if user info is invalid" do
      VCR.use_cassette("Channel") do
        response = Workspace.new
        expect { response.select_user("tildee") }.must_raise ArgumentError
      end
    end
  end
end

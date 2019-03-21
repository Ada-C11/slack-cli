require_relative "test_helper"
require "awesome_print"

describe SlackCLI do
  USER_URL = "https://slack.com/api/users.list"

  describe "User class" do
    let (:get_users) do
      VCR.use_cassette("user_get") do
        user = USER_URL
        param = ENV["SLACK_API_TOKEN"]
        SlackCLI::User.get(user, param)
      end
    end
    let (:list_users) do
      VCR.use_cassette("user_get") do
        user = USER_URL
        param = ENV["SLACK_API_TOKEN"]
        SlackCLI::User.list(user, param)
      end
    end
    describe "self.get" do
      it "imports list of users from slack" do
        VCR.use_cassette("user_get") do
          user = USER_URL
          param = ENV["SLACK_API_TOKEN"]
          expect(SlackCLI::User.get(user, param)).must_be_kind_of HTTParty::Response
        end
      end
    end

    describe "self.list" do
      it "formats the list of users" do
        get_users
        expect(list_users).must_be_kind_of Array
        ap list_users
      end
    end

    describe "selecting a user" do
      it "creates an instance of user" do
        expect(SlackCLI::User.new("myriam.waldend", "UH2P4B8R1", "myriam.waldend")).must_be_kind_of SlackCLI::User
      end
    end

    describe "self.details" do
      it "gives a description of the user" do
        get_users
        list_users
        expect(SlackCLI::User.details("UH2P4B8R1")).must_be_kind_of String
        ap SlackCLI::User.details("UH2P4B8R1")
      end
      it "raises ArgumentError when the user does not exist" do
        get_users
        list_users
        expect { SlackCLI::User.details("IMACATIMAKITTYCAT") }.must_raise ArgumentError
      end
    end

    describe "message method" do
      it "sends a message to the user" do
        VCR.use_cassette("slack_message") do
          text = "Interesting info:
        Ron Swanson is a fictional character 
        portrayed by actor Nick Offerman. 
        The Ron Swanson Quotes API was developed 
        by James Wright, an independent web developer. 
        This API lets other developers integrate...
        for more info go to their website"
          user = "UH2P4B8R1"
          expect(SlackCLI::User.message(text, user)).must_equal true
        end
      end
      it "raises Argument error when there is no message" do
        VCR.use_cassette("slack_message") do
          text = ""
          user = "UH2P4B8R1"
          expect { SlackCLI::User.message(text, user) }.must_raise ArgumentError
        end
      end
      it "raises Argument error when the user does not exist" do
        VCR.use_cassette("slack_message") do
          text = "Hello, this message is never going to get sent"
          user = "IMACATIMAKITTYCAT"
          expect { SlackCLI::User.message(text, user) }.must_raise ArgumentError
        end
      end
    end
  end
end

require_relative "test_helper"
require "awesome_print"

describe SlackCLI do
  USER_URL = "https://slack.com/api/users.list"

  describe "User class" do
    let (:get_list) do # To be used in some test when the method requires data that comes from the Slack API
      VCR.use_cassette("user_get") do
        user = USER_URL
        param = ENV["SLACK_API_TOKEN"]
        expect(SlackCLI::User.get(user, param)).must_be_kind_of HTTParty::Response
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
        get_list
        expect(SlackCLI::User.list).must_be_kind_of Array
        ap SlackCLI::User.list
      end
    end

    describe "selecting a user" do
      it "creates an instance of user" do
        # the instantiation of User class should happen in workspace
        expect(SlackCLI::User.new("myriam.waldend", "UH2P4B8R1")).must_be_kind_of SlackCLI::User
      end
    end

    describe "self.details" do
      it "gives a description of the user" do
        get_list
        expect(SlackCLI::User.details("UH2P4B8R1")).must_be_kind_of String
        puts SlackCLI::User.details("UH2P4B8R1")
      end
      it "raises ArgumentError when the user does not exist" do
        get_list
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

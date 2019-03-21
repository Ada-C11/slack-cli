require_relative "test_helper"

describe Slack do
  describe "list users method" do
    it "lists all of the users" do
      VCR.use_cassette("list_users") do
        response = Slack::User.list_users

        # expect that it must have the right amount of users
        # expect that keys must include usernames
        # expect that it won't be nil
      end
    end
  
  end

  describe "select users method" do
    it "raises an error for bogus user names" do
      # creates and new user instance
      # VCR to select user
      # expect that using the select user method on a fake username generates slack error

    end

    it "chooses the correct user when user name is inputted" do
      # create a new user instance
      # VCR for the select user method
      # select the user using response (either steph or faiza's username)
      # expect that the result should equal mine or faiza's username
    end

    it "chooses the correct user when id is inputted" do
      # create a new instance of user
      # VCR for select user
      # select user using an id key
      # expect that the result should equal the id key we enetered
    end

  end

  describe "show details method" do
    it "displays the information of the currently selected user" do
      # create a new user instance
      # VCR to select user
      # set variable equal to selected user
      # set variable equal to user details
      # expect that it's a hash
      # expect that the user details contains what it is supposed to
    end

  end
end
require_relative "test_helper"

describe "Workspace" do
  describe "Initialize" do
    before do
      VCR.use_cassette("initialize") do
        @workspace = SlackBot::Workspace.new
      end
    end
    it "Creates a workspace object" do
      expect(@workspace).must_be_kind_of SlackBot::Workspace
    end

    it "Initializes with selected equal to nil" do
      expect(@workspace.selected).must_equal nil
    end
    it "Creates a list of users" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users.first).must_be_kind_of SlackBot::User
      #   expect(@workspace.users.first.real_name).must_equal "Slackbot"
      #   expect(@workspace.users.first.name).must_equal "slackbot"
      #   expect(@workspace.users.first.name).must_equal "USLACKBOT"
    end
  end
  describe "select" do
    before do
      VCR.use_cassette("select") do
        @workspace = SlackBot::Workspace.new
      end
    end
    it "returns nil if no user found with id given" do
      selected = @workspace.select_user("USLACKNOT")
      expect(selected).must_equal nil
    end
    it "returns nil if no user found with name given" do
      selected = @workspace.select_user("Devin")
      expect(selected).must_equal nil
    end
    # it "returns a User object if given a valid user id" do
    #   selected = @workspace.select_user("USLACKBOT")
    #   expect(selected).must_be_kind_of SlackBot::User
    #   expect(selected["name"]).must_equal "slackbot"
    # end
    # it "returns a User object if given a valid user name" do
    #   selected = @workspace.select_user("slackbot")
    #   expect(selected).must_be_kind_of SlackBot::User
    #   expect(selected["name"]).must_equal "USLACKBOT"
    # end
  end
end

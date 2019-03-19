require_relative "test_helper"

describe "Workspace" do
    describe "Initialize" do
        it "Creates a workspace object" do
            VCR.use_cassette("initialize") do
                expect(SlackBot::Workspace.new).must_be_kind_of SlackBot::Workspace
            end    
        end
        it "Creates a list of users" do
            VCR.use_cassette("initialize") do
                user = SlackBot::Workspace.new
                expect(user.users).must_be_kind_of Array
                expect(user.users.first).must_be_kind_of Hash
                expect(user.users.first.keys).must_equal [:real_name, :name, :id]
                expect(user.users.first.values).must_equal ["Slackbot", "slackbot", "USLACKBOT"]

            end
        end
    end
end
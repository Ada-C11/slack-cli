require 'test_helper'


describe "Workspace Class" do 
    it "will return a list of user instances" do
            VCR.use_cassette("workspace_information_find") do
                workspace = Slack::Workspace.new
                expect(workspace.users).must_be_kind_of Array
                expect(workspace.users[0]).must_be_kind_of Slack::User
            end
    end
end

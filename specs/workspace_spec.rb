require_relative "test_helper"

describe "Workspace Class" do
    describe "initialize method" do
      it "lists users and channels" do
        VCR.use_cassette("workspace information") do
          workspace = Slack::Workspace.new
          expect(workspace.users).must_be_kind_of(Array)
          expect(workspace.channels).must_be_kind_of(Array)
        #   (0..2).each do |i|
        #     expect(workspace.users[i]).must_be_kind_of(Slack::User)
        #     expect(workspace.channels[i]).must_be_kind_of(Slack::Channel)
        #   end
        end
      end
    end

    describe "select user method" do
      it "stores user inputted username in selection variable" do
        VCR.use_cassette("workspace information") do
        user_names = ["smarcha04", "faiza.ahsan1222", "slackbot"]
        real_names = ["Stephanie Marchante", "Faiza Husain", "Slackbot"]
        workspace = Slack::Workspace.new
    
        user_names.each_with_index do |user_name, i|
          find_user = workspace.select_user(user_name)
            selected_user = workspace.selection
            expect(selected_user).must_be_kind_of Slack::User
            expect(selected_user.real_name).must_equal "#{real_names[i]}"
          end
        end
      end

      it "stores user inputted slackid in selection variable" do
        VCR.use_cassette("workspace information") do
          all_slack_ids = ["UH2NWFHTM", "UH2NX89A7", "USLACKBOT"]
          all_real_names = ["Faiza Husain", "Stephanie Marchante","Slackbot"]

          workspace = Slack::Workspace.new

          all_slack_ids.each_with_index do |slackid, i|
            user_search = workspace.select_user(slackid)
            select_user = workspace.selection
            expect(select_user).must_be_kind_of(Slack::User)
            expect(select_user.real_name).must_equal "#{all_real_names[i]}"
          end
        end

      end
    end
    
end






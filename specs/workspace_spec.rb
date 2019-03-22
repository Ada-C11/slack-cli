require 'minitest'
require_relative 'test_helper.rb'

describe "Workspace" do
  before do
    VCR.use_cassette("load_workspace") do
      response = SlackAPI::User.load
      response2 = SlackAPI::Channel.load
      @workspace = SlackAPI::Workspace.new(users: response, channels: response2)
     end
  end

  describe "select_user" do
    it "selects a user when name is provided" do
      @workspace.select_user(id_or_name:"slackbot")
      expect(@workspace.selected).must_be_kind_of SlackAPI::User
      expect(@workspace.selected.name).must_equal "slackbot"
    end

    it "selects a user when id is provided" do
      @workspace.select_user(id_or_name:"USLACKBOT")
      expect(@workspace.selected).must_be_kind_of SlackAPI::User
      expect(@workspace.selected.slack_id).must_equal "USLACKBOT"
    end
  end

  describe "select_channel" do
    it "returns nil if no user / channel is selected" do
      expect(@workspace.selected).must_be_nil
    end
    
    it "selects a channel when id is provided" do
      @workspace.select_channel(id_or_name:"CH2SBU69Y")
      expect(@workspace.selected).must_be_kind_of SlackAPI::Channel
      expect(@workspace.selected.slack_id).must_equal "CH2SBU69Y"
    end

    it "selects a channel when name is provided" do
      @workspace.select_channel(id_or_name:"everyone")
      expect(@workspace.selected).must_be_kind_of SlackAPI::Channel
      expect(@workspace.selected.name).must_equal "everyone"
    end

    it "returns nil if channel is not found" do
      @workspace.select_channel(id_or_name:"madeup_channel")
      expect(@workspace.selected).must_be_nil
    end
  end
  
  describe "show_details" do
    it "shows details for a selected user" do
      @workspace.select_user(id_or_name:"slackbot")
      expect(@workspace.show_details).must_be_kind_of Hash
      expect(@workspace.show_details[:real_name]).must_equal @workspace.selected.real_name
      expect(@workspace.show_details[:slack_id]).must_equal @workspace.selected.slack_id
      expect(@workspace.show_details[:name]).must_equal @workspace.selected.name
    end

    it "shows details for a selected channel" do
      @workspace.select_channel(id_or_name:"everyone")
      expect(@workspace.show_details).must_be_kind_of Hash
      expect(@workspace.show_details[:slack_id]).must_equal @workspace.selected.slack_id
      expect(@workspace.show_details[:name]).must_equal @workspace.selected.name
      expect(@workspace.show_details[:topic]).must_equal @workspace.selected.topic
      expect(@workspace.show_details[:member_count]).must_equal @workspace.selected.member_count
    end
    
  end
  
  describe "send_message" do

  end
end
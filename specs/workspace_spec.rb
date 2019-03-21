require 'minitest'
require_relative 'test_helper.rb'

describe "Workspace" do
  before do

  end

  describe "select_channel" do
    
  end

  describe "select_user" do
    before do
      workspace = SlackAPI::Workspace()
    end
    it "selects a user when one is provided" do
      expect(SlackAPI::User.list).must_be_kind_of Array
    end
        end
  
    end
  
  end
    
  describe "show_details" do

  end
  
  describe "send_message" do

  end
end
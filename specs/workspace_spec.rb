require "dotenv"

require_relative './test_helper'
require_relative '../lib/workspace'

describe "workspace" do
  before do
    Dotenv.load('.env')
    api_token = ENV['SLACK_API_TOKEN']
    @workspace = Workspace.new(api_token)
  end

  describe "channels" do
    it "must be instance of array" do
      VCR.use_cassette("good channels") do
        channels = @workspace.channels
        expect(channels).must_be_kind_of Array
      end
    end
  end

  describe "users" do
    it "must be instance of array" do
      VCR.use_cassette("good users") do
        users = @workspace.users
        expect(users).must_be_kind_of Array
      end
    end

    it "must raise exception for bad response" do
      workspace = Workspace.new('badapitoken')
      VCR.use_cassette("bad channels") do
        expect{workspace.channels}.must_raise RuntimeError
      end
    end
  end

  describe "select_user" do
    it "finds a user by username" do
      VCR.use_cassette("select user") do
        # expect{workspace.select_user}.must_be
        # arrange
        user_name = "kateannnichols"
        # act
        selected_user = @workspace.select_user(user_name)
        # assert
        expect(selected_user.username).must_equal 'kateannnichols'
      end
    end
    it "finds a user by id" do
      VCR.use_cassette("select user") do
        slack_id = "UH2SA7YJE"
        selected_user = @workspace.select_user(slack_id)
        expect(selected_user.slack_id).must_equal 'UH2SA7YJE'
      end
    end
  end
end

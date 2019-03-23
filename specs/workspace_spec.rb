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

  describe "select_channel" do
    it "finds a chanel by channel name" do
      VCR.use_cassette("select channel by name") do
        # expect{workspace.select_user}.must_be
        # arrange
        channel_name = "random"
        # act
        selected_channel = @workspace.select_channel(channel_name)
        # assert
        expect(selected_channel.name).must_equal 'random'
      end
    end

    it "finds a channel by id" do
      VCR.use_cassette("select channel by id") do
        id = "CH36Q9YKX"
        selected_channel = @workspace.select_channel(id)
        expect(selected_channel.id).must_equal 'CH36Q9YKX'
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
        id = "UH2SA7YJE"
        selected_user = @workspace.select_user(id)
        expect(selected_user.id).must_equal 'UH2SA7YJE'
        end
      end
    end
  end
end

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
  end
end

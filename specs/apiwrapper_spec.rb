require_relative "test_helper"

describe "Api Wrapper module" do
  describe "Api Wrapper module" do
    it "responds to get_users and get_channels" do
      expect(Slack::ApiWrapper).must_respond_to :get_users
      expect(Slack::ApiWrapper).must_respond_to :get_channels
    end
  end

  describe "ApiWrapper.get_users" do
    it "will return with array" do
      expect(Slack::ApiWrapper.get_users).must_be_instance_of Array
    end
  end
end

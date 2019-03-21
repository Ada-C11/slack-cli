require_relative "test_helper"

describe "Api Wrapper module" do
  describe "Api Wrapper module" do
    it "responds to get_users and get_channels" do
      expect(Slack::ApiWrapper).must_respond_to :get_users
      expect(Slack::ApiWrapper).must_respond_to :get_channels
    end
  end

  describe "ApiWrapper.get_users" do
    it "will return a Response object" do
      VCR.use_cassette("slack_api") do
        response = Slack::ApiWrapper.get_users
        expect(response).must_be_instance_of HTTParty::Response
      end
    end
  end

  describe "ApiWrapper.get_channels" do
    it "will return a Response object" do
      VCR.use_cassette("slack_api") do
        response = Slack::ApiWrapper.get_channels
        expect(response).must_be_instance_of HTTParty::Response
      end
    end
  end

  describe "ApiWrapper.post" do
    it "will return a Response object" do
      VCR.use_cassette("slack_api") do
        response = Slack::ApiWrapper.post(text: "test text", recipient: "random")
        expect(response).must_be_instance_of HTTParty::Response
      end
    end
  end
end

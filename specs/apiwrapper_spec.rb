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

    # it "will return a " do
    #   VCR.use_cassette("slack_api") do
    #     response = get_users
    #     response["users"].each do |user|
    #       expect(user["name"]).
    #     end
    #   end
    # end
  end

  describe "ApiWrapper.get_json" do
    it "will return a Response object" do
      VCR.use_cassette("slack_api") do
        url = "users.list"
        query = {
          token: ENV["SLACK_API_KEY"],
        }
        response = Slack::ApiWrapper.get_json(url_tail: url, query_params: query)
        expect(response).must_be_instance_of HTTParty::Response
      end
    end

    it "raises an error when receiving invalid url" do
      VCR.use_cassette("slack_api") do
        url = "somethin.gelse"
        query = {
          token: ENV["SLACK_API_KEY"],
        }
        expect {
          Slack::ApiWrapper.get_json(url_tail: url, query_params: query)
        }.must_raise Slack::ApiWrapper::SlackError
      end
    end
  end
end

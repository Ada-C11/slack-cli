require_relative "test_helper"

describe "Api Wrapper module" do
  describe "Api Wrapper module" do
    it "responds to get_users and get_channels" do
      expect(Slack::ApiWrapper).must_respond_to :get_users
      expect(Slack::ApiWrapper).must_respond_to :get_channels
    end
  end

  describe "ApiWrapper.get_json" do
    it "successfully gets a json object" do
      url_tail = "users.list"
      VCR.use_cassette("slack_api") do
        response = Slack::ApiWrapper.get_json(url_tail: url_tail)
        expect(response).must_be_instance_of HTTParty::Response
      end
    end

    it "raise an error if an invalid url is used" do
      url_tail = "abc"
      VCR.use_cassette("slack_api") do
        response =
          expect {
            Slack::ApiWrapper.get_json(url_tail: url_tail)
          }.must_raise Slack::ApiWrapper::SlackError
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
    it "can send a valid message to a channel" do
      VCR.use_cassette("slack_api") do
        response = Slack::ApiWrapper.post(text: "test text", recipient: "random")
        expect(response).must_equal true
      end
    end

    it "can send a valid message to a user" do
      VCR.use_cassette("slack_api") do
        user_id = "UH2RH81RA"
        response = Slack::ApiWrapper.post(text: "test text", recipient: user_id)
        expect(response).must_equal true
      end
    end

    it "will raise exception if invalid channel used" do
      VCR.use_cassette("slack_api") do
        user_id = "Noarealid234"
        expect {
          Slack::ApiWrapper.post(text: "test text", recipient: user_id)
        }.must_raise Slack::ApiWrapper::SlackError
      end
    end

    it "will raise exception if no text is provided" do
      VCR.use_cassette("slack_api") do
        user_id = "UH2RH81RA"
        expect {
          Slack::ApiWrapper.post(text: "", recipient: user_id)
        }.must_raise Slack::ApiWrapper::SlackError
      end
    end
  end
end

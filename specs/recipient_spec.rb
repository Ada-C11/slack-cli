require_relative "test_helper"

describe SlackCLI::Recipient do
  before do
    @slack_id = "CH2SKTDBN"
    @name = "random"
    @record = SlackCLI::Recipient.new(slack_id: @slack_id, name: @name)
  end
  describe "constructor" do
    it "is an instance of Recipient" do
      expect(@record).must_be_kind_of SlackCLI::Recipient
    end

    it "takes and saves a Slack id and name" do
      expect(@record.slack_id).must_equal @slack_id
      expect(@record.name).must_equal @name
    end
  end

  describe "self.get" do
    it "gets a response" do
      VCR.use_cassette("recipient") do
        url = "http://slack.com/api/users.list"
        params = {"token": ENV["SLACK_API_TOKEN"]}

        response = SlackCLI::Recipient.get(url, params)
        expect(response).wont_be_nil
        expect(response).must_be_kind_of HTTParty::Response
        expect(response.code).wont_equal 401
      end
    end

    it "raises an error when given bad params" do
      VCR.use_cassette("recipient") do
        url = "https://slack.com/api/users.list"
        data = {
          "token": "BAD TOKEN",
        }
        exception = expect { SlackCLI::Recipient.get(url, data) }.must_raise SlackCLI::Recipient::SlackApiError
        expect(exception.message).must_equal "Error when getting response, error: invalid_auth"
      end
    end
  end

  describe "send message" do
    it "can send a valid message" do
      VCR.use_cassette("recipient") do
        response = @record.send_message("Hey I can post messages!")
        expect(response).must_equal true
      end
    end

    it "will raise an error when given an invalid channel" do
      VCR.use_cassette("recipient") do
        slack_id = "invalid_id"
        name = "invalid-channel"
        bad_record = SlackCLI::Recipient.new(slack_id: slack_id, name: name)
        exception = expect {
          bad_record.send_message("This post should not work")
        }.must_raise SlackCLI::Recipient::SlackApiError

        expect(exception.message).must_equal "Error when posting This post should not work to invalid_id, error: channel_not_found"
      end
    end
  end
end

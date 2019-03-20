require_relative "test_helper"

describe SlackCLI::Recipient do
  describe "constructor" do
    before do
      @slack_id = "CH2SKTDBN"
      @name = "random"
      @record = SlackCLI::Recipient.new(slack_id: @slack_id, name: @name)
    end

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
  end

  describe "send message" do
    it "can send a valid message" do
      VCR.use_cassette("recipient") do
        response = SlackCLI::Recipient.send_message("Hey I can post messages!")
        expect(response).must_equal true
      end
    end
  end
end

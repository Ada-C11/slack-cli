require_relative "test_helper"

describe "Recipient" do
  describe "initialize" do
  end

  describe "send message" do
    it "can post a message on the everyone slack channel" do
      VCR.use_cassette("message_post") do
        name = "everyone"
        text = "hello world"
        pigeon = Recipient.send_message(name: name, message: text)

        expect(pigeon["ok"]).must_equal true
      end
    end

    it "raises a SlackError with bad parameters" do
      VCR.use_cassette("message_post") do
        name = ""
        text = "this should not send"

        expect {
          Recipient.send_message(name: name, message: text)
        }.must_raise SlackError
      end
    end
  end

  # describe "self.get method" do 
  #   it "successfully returns users list HTTP response object" do 
  #     VCR.use_cassette("get_response") do 
  #       url = "https://slack.com/api/users.list"
  #       params = {
  #         token: ENV["SLACK_TOKEN"],
  #       }
  #       party_people = Recipient.get(url, params)

  #       expect(party_people["ok"]).must_equal true
  #     end
  #   end

  #   it "raises SlackError for inauthorization" do
  #     VCR.use_cassette("get_response") do 
  #       url = "https://slack.com/api/users.list"
  #       params = {
  #         token: "thisisbadtoken",
  #       }

  #       expect {
  #         Recipient.get(url, params)
  #       }.must_raise SlackError
  #     end
  #   end
  # end
end

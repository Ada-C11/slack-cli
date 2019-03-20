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
end

require_relative "test_helper"

describe "Recipient" do
  describe "initialize" do
  end

  describe "send message" do
    it "can post a message on the everyone slack channel" do
      VCR.use_cassette("message_post") do
        name = "everyone"
        text = "Hey there"
        pigeon = Recipient.send_message(name, text)

        expect(pigeon["ok"]).must_equal true
      end
    end
  end
end

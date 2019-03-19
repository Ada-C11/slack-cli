require_relative "test_helper"

describe "Recipient" do
  describe "initialize" do
  end

  describe "send message" do

    it "can post a message on the everyone slack channel" do
      VCR.use_cassette("message_post") do
        name = "everyone"
        text = "Hey there%21"
        pigeon = Recipient.send_message(name: name, message: text)

        expect(pigeon["ok"]).must_equal true
      end

      it "raises an exception for bad request" do 
        
      end
    end
  end
end

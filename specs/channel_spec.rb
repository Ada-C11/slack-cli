require_relative "test_helper"

describe "Channel class" do
  describe "self.list" do
    it "can return all channels" do
      VCR.use_cassette("slack_channel") do
        response = Channel.get("channel")

        expect(response["channels"]).wont_be_nil
        expect(response["channels"].first["name"]).must_equal "random"
      end
    end 
  end
end
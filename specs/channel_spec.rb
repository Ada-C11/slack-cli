require_relative "test_helper"

describe "channel" do
  describe "self.list" do
    it "Returns an array of hashes" do
      VCR.use_cassette("self.list") do
        channel_list = SlackBot::Channel.list

        expect(channel_list).must_be_kind_of Array
        expect(channel_list.first).must_be_kind_of SlackBot::Channel
        expect(channel_list.last).must_be_kind_of SlackBot::Channel
      end
    end
    it "Returns a real_name" do
        VCR.use_cassette("self.list") do
            channel_list = SlackBot::Channel.list

        expect(channel_list.first.num_members).must_equal 2
        expect(channel_list.first.id).must_equal "CH2P99HT5"
        expect(channel_list.first.name).must_equal "slack-api-project"
        end
    end
  end
  describe "send message" do
    before do 
      VCR.use_cassette("send message to channel") do
        @channel_list = SlackBot::Channel.list
      end
    end
      
     it "returns true if given a valid message" do
      VCR.use_cassette("send message with empty string to channel") do
        message = "Hello!"
        expect(@channel_list.first.send_message(message)).must_equal true
      end
    end

    it "returns a slackapierror when given an empty string" do
      VCR.use_cassette("send message with empty string to channel") do
        message = ""
        expect {
        @channel_list.first.send_message(message)
        }.must_raise SlackBot::SlackApiError
      end
    end
  end
end

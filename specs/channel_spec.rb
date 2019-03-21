require_relative "test_helper"

describe "Channel Initialize" do
#   before do
#     @new_channel = Slack::Channel.new(
#       1,
#       "Ada_C11",
#       "api_discussion",
#     )
#   end

#   it "will create an instance of Channel" do
#     expect(@new_channel).must_be_instance_of Slack::Channel
#   end # it

  describe "list channels method" do
    it "can list all of the channels" do
      VCR.use_cassette("list_channels") do
        expect(Slack::Channel.channel_list).wont_be_nil
        # expect that the member count will be equal to two
        # expect that one of the keys will include random
        # expect that the number of channels will be 2 (Or is it 3? lol)
      end # VCR
    end # it
  end

  describe "select channel method" do
    it "selects channel when user inputs the name of the channel" do
      channel = Slack::Channel.new
      VCR.use_cassette("select channel") do
        response = channel.select_channel()
        exepct(response).must_equal()
    end

    
    it "selects the channel when user inputs id" do
      channel = Slack::Channel.new
      VCR.use_cassette("select channel id") do
        response = channel.select_channel()
        expect(response).must_equal()
    end

    it "raises and error if the inputted channel name is not valid" do
      expect{"bogusname"}.must_raise Slack::SlackError
    end
    
  end

  describe "show details method" do
    it "displays the details for the currently selected channel" do
      channel = Slack.Channel.new
      channel_selection = channel.select_channel()
      # set variable equal to selected channel
      details = channel.show_details()
      expect(details).must_be_instance_of(Hash)
      expect()
      # set variable equal to channel details
      # expect that it's a hash
      # expect that the channel contains what it is supposed to
    end
  end
end # outer describe

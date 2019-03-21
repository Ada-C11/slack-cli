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
      # create new instance of channel, or can we use before do?
      # VCR for the select channel method
      # use response and set it equal to the select channel method with channel name as a parameter
      # expect that response must equal whatever the channel name is
    end

    
    it "selects the channel when user inputs id" do
      # create a new instance of channel
      # VCR for the select channel method
      # use response and set it equal to the select channel method with an id as a parameter
      # expect that response must equal whater the id is
    end

    it "raises and error if the inputted channel name is not valid" do
      # expect that a fake channel name must raise our slack error
    end
    
  end

  describe "show details method" do
    it "displays the details for the currently selected channel" do
      # create new channel instance
      # set variable equal to selected channel
      # set variable equal to channel details
      # expect that it's a hash
      # expect that the channel contains what it is supposed to
    end
  end
end # outer describe

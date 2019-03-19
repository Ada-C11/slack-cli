require_relative 'test_helper'

describe "channel" do
  it "instantiate a channel object" do
    VCR.use_cassette("slack_channels") do
       
      new_channel = SlackCLI::Channel.new(
        "CH2P2QWMR", "everyone",  
        {"value"=>"Company-wide announcements and work-based matters", 
          "creator"=>"UH36TMYKF", 
          "last_set"=>1552952569}, 2)

          expect(new_channel).must_be_instance of Channel
    end
  end  

  it "raises an error if query fails" do
    response = HTTParty.get(BASE_URL, query: query_parameters)
  end
   
end
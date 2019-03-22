require_relative 'test_helper'
  
describe "Channel class" do
  describe "initialization" do
    it "is an instance of a channel" do
       VCR.use_cassette("initialize") do
        channel = Channel.new(slack_id: 1, name: "always hungry", topic: "eating, what else?", member_count: 2 ) 
      
        expect(channel).must_be_kind_of Channel
        expect(channel.name).must_equal "always hungry"
        expect(channel.topic).must_equal "eating, what else?"
       end
    end
    
    describe "list and get methods" do
      it "returns an array of channels" do
        VCR.use_cassette("list-and-get") do
          expect(Channel.list).must_be_kind_of Array
          expect(Channel.get("channels.list")).must_be_kind_of HTTParty::Response
          expect(Channel.list[1]).must_be_instance_of Channel
        end
      end
      
      it "returns an instance of Response" do
        VCR.use_cassette("list-and-get") do
          expect(Channel.get("channels.list")).must_be_kind_of HTTParty::Response
        end
      end
    end
  end
end
require_relative "test_helper"

describe "Channel class" do
  describe "Channel#list" do
    it "will raise an exception if the search fails" do
      VCR.use_cassette("Channel") do
        response = Channel.list
        expect { response }.must_include "general"
      end
    end
  end
end

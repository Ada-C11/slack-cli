require_relative "test_helper"

describe "Channel class" do
  describe "self.list" do
    it "can return all channels" do
      VCR.use_cassette("slack_channel") do
        response = Channel.list

        channel = response.first

        expect(response).wont_be_nil
        expect(response.first.name).must_equal channel.name
      end
    end
  end
end

# members = response[0].members.count
# expect(response.first.member_count).must_equal members

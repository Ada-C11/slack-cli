describe "Recipient class" do
  describe "" do
    it "can get raw data for user and channel" do
      VCR.use_cassette("slack_channel") do
        type = "user"
        expect(response).wont_be_nil
        expect(response.first.name).must_equal channel.name
      end
    end
  end
end

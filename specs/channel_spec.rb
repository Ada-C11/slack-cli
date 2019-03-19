require_relative "test_helper.rb"

describe "self.list" do
  it "list all channels" do
    VCR.use_cassette("list_channels") do
      response = Channel.list_channels

      expect(response).wont_be_nil
      expect(response.keys.include?("general")).must_equal true
      expect(response["general"]).must_equal "topic" => "Company-wide announcements and work-based matters",
        "member count" => 2,
        "id" => "CH2SKTKPC"
      expect(response.length).must_equal 3
    end
  end
  it "will raise an error if the response code is not 200" do
    #fill this in later?
  end
end

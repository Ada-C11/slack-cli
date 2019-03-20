require_relative "test_helper"

describe "self get method" do
  it "successfully returns users list HTTP response object" do
    VCR.use_cassette("get_response") do
      party_people = Channel.get

      expect(party_people["ok"]).must_equal true
    end
  end

  it "raises SlackError for inauthorization" do
  end
end

require_relative "test_helper"

describe "Channel class" do
  describe "Channel#list" do
    it "finds channels" do
      VCR.use_cassette("Channel") do
        location = "Seattle"
        response = get_location(location)

        expect(response["Seattle"]).wont_be_nil
        expect(response["Seattle"][:lon]).must_equal "-122.3300624"
        expect(response["Seattle"][:lat]).must_equal "47.6038321"
      end
    end

    it "will raise an exception if the search fails" do
      VCR.use_cassette("Channel") do
        location = ""
        expect {
          response = get_location(location)
        }.must_raise SearchError
      end
    end
  end
end

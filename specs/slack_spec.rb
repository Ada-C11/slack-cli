require_relative "test_helper"

describe "SlackAPI" do
  it "can send a valid message" do
    VCR.use_cassette("slack_message") do
      location = "Seattle"
      response = get_location(location)

      expect(response["Seattle"]).wont_be_nil
      expect(response["Seattle"][:lon]).must_equal "-122.3300624"
      expect(response["Seattle"][:lat]).must_equal "47.6038321"
    end
  end

  it "will raise an exception if the search fails" do
    VCR.use_cassette("location_find") do
      location = ""
      expect {
        response = get_location(location)
      }.must_raise SearchError
    end
  end
end

# describe "Listing Channels and Users" do
#   it "list channels" do
#     VCR.use_cassette("channels_find") do
#       location = "Seattle"
#       response = get_location(location)

#       expect(response["Seattle"]).wont_be_nil
#       expect(response["Seattle"][:lon]).must_equal "-122.3300624"
#       expect(response["Seattle"][:lat]).must_equal "47.6038321"
#     end
#   end

#   it "list users" do
#     VCR.use_cassette("location_find") do
#       user = "" # name parameter in slack api
#       expect {
#         response = get_location(location)
#       }.must_raise SearchError
#     end
#   end
# end

require_relative "test_helper"

describe "list" do
  it "can get a list of users" do
    VCR.use_cassette("list users") do
      response = User.list
      expect(response).wont_be_nil
      expect(response["members"]).must_be_kind_of Array
    end
  end
  # it "will raise an exception if the search fails" do
  #   VCR.use_cassette("list user") do
  #     location = ""
  #     expect {
  #       response = get_location(location)
  #     }.must_raise SearchError
  #   end
  # end


end

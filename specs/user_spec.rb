require_relative "test_helper"

describe "list" do
  it "can get a list of users" do
    VCR.use_cassette("list_of_users") do
      response = User.list
      expect(response).wont_be_nil
      #expect(response["members"]["id"]).must_equal "USLACKBOT"
    end
  end
end

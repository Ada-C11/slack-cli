require_relative "test_helper"

describe "self.list" do
  it "list all users" do
    VCR.use_cassette("list_users") do
      response = User.list_users

      expect(response).wont_be_nil
      expect(response.keys.include?("aribray")).must_equal true
      expect(response["aribray"]).must_equal "real name" => "Ariana Bray",
        "slack id" => "UH3UT3SJK"
      expect(response.length).must_equal 3
    end
  end
end

describe "select_user" do
  it "selects a user as the current recipient" do
    user = User.new
    VCR.use_cassette("select_user") do
      response = user.select_user("UH3UT3SJK")

      expect(response).must_equal "UH3UT3SJK"
    end
  end
end

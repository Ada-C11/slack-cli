require_relative 'test_helper'

describe "self.list" do
  it "list all users" do
    VCR.use_cassette("list_users") do
      response = User.list_users

      expect(response).wont_be_nil
      expect(response.keys.include?("aribray")).must_equal true
      expect(response["aribray"]).must_equal "real_name" => "Ariana Bray",
        "id" => "CH2SKTKPC"
      expect(response.length).must_equal 2
    end
  end
end

require_relative "test_helper"

describe "User class" do
  describe "self.list" do
    it "can return all channels" do
      VCR.use_cassette("slack_user") do
        response = User.list
        user = response.first

        expect(response).wont_be_nil
        expect(response.first.name).must_equal user.name
      end
    end
  end
end

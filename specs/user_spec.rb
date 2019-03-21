require_relative "test_helper"

describe Slack do
  describe "self.list_users" do
    it "lists all of the users" do
      VCR.use_cassette("list_users") do
        response = Slack::User.list_users

        expect(response.length).must_equal(3)
        expect(response).wont_be_nil
        expect(response.keys.include?()).must_equal(true)

    end
  
  end

end
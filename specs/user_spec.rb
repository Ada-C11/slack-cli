require_relative "test_helper"

describe "User" do
  describe "Initialization" do
    let(:slack_id) { 20 }
    let(:username) { "soph" }
    let(:real_name) { "Sopheary" }
    let(:status_text) { "Good to go" }
    let(:status_emoji) { ":)" }

    it "can be instantiated" do
      user = Slack::User.new(slack_id, username, real_name, status_text, status_emoji)
      expect(user).must_be_instance_of Slack::User
      expect(user.slack_id).must_equal 20
      expect(user.name).must_equal "soph"
      expect(user.real_name).must_equal "Sopheary"
      expect(user.status_text).must_equal "Good to go"
      expect(user.status_emoji).must_equal ":)"
    end

    # it "can find a location" do
    #   VCR.use_cassette("users_found") do
    #     response = get_location(location)

    #     expect(response["Seattle"]).wont_be_nil
    #     expect(response["Seattle"][:lon]).must_equal "-122.3300624"
    #     expect(response["Seattle"][:lat]).must_equal "47.6038321"
    #   end
    # end
  end
end

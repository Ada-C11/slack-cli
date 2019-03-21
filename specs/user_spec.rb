require_relative "test_helper"

describe "returning user lists" do
  it "API returns as a hash and its members return as an array" do
    VCR.use_cassette("slack_users") do
      test_user = User.new

      expect(User.list).must_be_kind_of Array
      expect(User.list.first).must_be_kind_of Array
    end
  end

  it "make sure there are 3 members in the list" do
    VCR.use_cassette("slack_users") do
      test_user = User.new

      expect(User.list.length).must_equal 3
    end
  end

  it "lists correct username" do
    VCR.use_cassette("slack_users") do
      test_user = User.new

      print User.list
      expect(User.list[0][0]).must_equal "slackbot"
    end
  end
end

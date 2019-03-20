require_relative "test_helper"

describe "User class" do
  let(:user) {
    Slack::User.new(id: "123", name: "sam", real_name: "sam bones")
  }
  describe "User#initialize" do
    it "Checks type is User and type Recipient" do
      expect(user).must_be_instance_of Slack::User
      expect(user).must_be_kind_of Slack::Recipient
    end

    it "Checks instance variable name, real_name and id: respond & equal to" do
      expect(user.name).must_equal "sam"
      expect(user.real_name).must_equal "sam bones"
      expect(user.id).must_equal "123"
    end
  end

  # Check details method return String type

  describe "User#details" do
    it "returns a String" do
      expect(user.details).must_be_instance_of String
    end
  end

end

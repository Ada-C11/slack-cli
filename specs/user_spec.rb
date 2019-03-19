require_relative "test_helper"

describe "User" do
  before do
    @user = User.new(1010, "shrutifruity", "Shruti", "droppin' knowledge", ":books:")
  end

  it "is an instance of user" do
    VCR.use_casette "initialize" do
      expect(@user).must_be_kind_of User
    end
  end

  it "returns details about a user" do
    VCR.use_casette "details" do
      expect(@user.details).must_be_kind_of Array
    end
  end

  it "returns a list of users" do
    VCR.use_casette "self.list" do
      expect(@user.self.list).must_be_kind_of Array
    end
  end
end

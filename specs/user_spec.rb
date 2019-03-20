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

# describe "User" do
#   before do
#     @user = User.new(1010, "shrutifruity", "Shruti", "droppin' knowledge", ":books:" )
#   end

#   it "is an instance of user" do
#     VCR.use_casette "initialize" do
#         expect(@user).must_be_kind_of User
#     end
#   end

#   it "returns details about a user" do
#     VCR.use_casette "details" do
#         expect(@user.details).must_be_kind_of Array
#   end

#   it "returns a list of users" do
#     VCR.use_casette "self.list" do
#         expect(@user.self.list).must_be_kind_of Array
#   end

# end

require_relative "test_helper"

describe "list" do
  it "can get a list of users" do
    VCR.use_cassette("list users") do
      users = User.list
      expect(users).wont_be_nil
      expect(users).must_be_kind_of Array
    end
  end
  # it "will raise an exception if the search fails" do
  #   VCR.use_cassette("list user") do
     
  #     expect {
        
  #     }.must_raise SearchError
  #   end
  # end


end

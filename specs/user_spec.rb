require_relative 'test_helper'

  
describe "User class" do
  describe "initialization" do
    it "is an instance of a user" do
       VCR.use_cassette("initialize") do
        user = User.new(slack_id: 1, name: "Amy", real_name: "MY") 
        
        expect(user).must_be_kind_of User
        expect(user.slack_id).must_equal 1
        expect(user.name).must_equal "Amy"
        expect(user.real_name).must_equal "MY"
       end
    end
    
    describe "list and get methods" do
      it "returns an array of users" do
        VCR.use_cassette("list-and-get") do
       
          expect(User.list).must_be_kind_of Array
          expect(User.get("users.list")).must_be_kind_of HTTParty::Response
          expect(User.list[0]).must_be_kind_of User
        end
      end
      
      it "returns an instance of Response" do
        VCR.use_cassette("list-and-get") do
          expect(User.get("users.list")).must_be_kind_of HTTParty::Response
        end
      end
    end
  end
end
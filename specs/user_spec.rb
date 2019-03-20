describe "User child class" do
  describe "initialize" do
  end

  describe "user self.list method" do 
    it "successfully returns an HTTParty response object" do
      VCR.use_cassette("user_response") do 
        expect(User.list["ok"]).must_equal true
      end
    end
  end

  describe "user self.list_users method" do 
    it "returns all usernames in workspace in array" do
      VCR.use_cassette("user_response") do 
        expect(User.list_users).must_be_kind_of Array 
        expect(User.list_users.length).must_equal 3
      end
    end
  end

  describe "user self.details method" do
    it "returns an array of hashes" do
      VCR.use_cassette("user_response") do
        expect(User.details).must_be_kind_of Array  
        User.details.each do |user|
          user.must_be_kind_of Hash
        end
      end
    end

    it "returns the correct details" do
      VCR.use_cassette("user_response") do
        expect(User.details.last[:real_name]).must_equal "Hana Clements"
        expect(User.details.last[:status_text]).must_equal ":heart:"
        expect(User.details.last[:status_emoji]).must_equal ":green_heart:"
      end
    end
  end
end
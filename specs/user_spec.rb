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

  describe "User#details" do
    it "returns a String" do
      expect(user.details).must_be_instance_of String
    end

    it "Checks details return the accurate String: " do
      string_format = "Name: #{user.name}, \nReal Name: #{user.real_name}, \nID: #{user.id}"
      expect(user.details).must_equal string_format
    end
  end

  # user 2 - "UH2RH81RA"
  # "elise.pham88"
  # "elise.pham88"

  # channel 2 = "CH2P3NB0T"
  # "general"
  #  "Company-wide announcements and work-based matters"
  # 2

  describe "User.create_users" do
    before do
      VCR.use_cassette("slack_api") do
        @users = Slack::User.create_users
      end
    end

    it "will return an array" do
      expect(@users).must_be_instance_of Array
    end

    it "returns correct User objects" do
      expect(@users[1].name).must_equal "elise.pham88"
      expect(@users[1].id).must_equal "UH2RH81RA"
      expect(@users[1].real_name).must_equal "elise.pham88"
    end
  end
end

require_relative "test_helper"

describe SlackCLI::User do
  describe "constructor" do
    before do
      @slack_id = "CH2SKTDBN"
      @name = "FreddyBoi13"
      @real_name = "Alfred Molina"
      @record = SlackCLI::User.new(slack_id: @slack_id, name: @name, real_name: @real_name)
    end

    it "is an instance of User" do
      expect(@record).must_be_kind_of SlackCLI::User
    end

    it "takes and saves a Slack id, name, and real name" do
      expect(@record.slack_id).must_equal @slack_id
      expect(@record.name).must_equal @name
      expect(@record.real_name).must_equal @real_name
    end
  end

  describe "self.list" do
    it "returns an array of users" do
      VCR.use_cassette("users find") do
        users_array = SlackCLI::User.list

        expect(users_array).must_be_kind_of Array
        expect(users_array.first).must_be_kind_of SlackCLI::User
        expect(users_array.length).wont_equal 0
      end
    end
  end
end

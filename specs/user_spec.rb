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

  describe "class methods" do
    before do
      VCR.use_cassette("users") do
        @users_array = SlackCLI::User.list
      end
    end

    describe "self.list" do
      it "returns an array of users" do
        expect(@users_array).must_be_kind_of Array
        expect(@users_array.first).must_be_kind_of SlackCLI::User
        expect(@users_array.length).wont_equal 0
      end
    end

    describe "details" do
      before do
        @slack_id = "CH2SKTDBN"
        @name = "FreddyBoi13"
        @real_name = "Alfred Molina"
        @record = SlackCLI::User.new(slack_id: @slack_id, name: @name, real_name: @real_name)
        @detail = @record.details
      end

      it "returns a string" do
        expect(@detail).must_be_kind_of String
      end

      it "returns the correct information" do
        expect(@detail).must_equal "Slack ID: #{@slack_id}, username: #{@name}, real name: #{@real_name}"
      end
    end
  end
end

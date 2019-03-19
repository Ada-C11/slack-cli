require_relative "test_helper"

describe "Recipient Class" do
  describe "Recipient has attributes name and slack_id" do
    before do
      @test = SlackCLI::Recipient.new("abc12whatever", "HiChris")
    end

    it "name returns as a string for user" do
      expect(@test.name).must_be_kind_of String
    end

    it "id returns as a string for user" do
      expect(@test.id).must_be_kind_of String
    end
  end
end

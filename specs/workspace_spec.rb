require_relative "test_helper"

describe "Workspace class" do
  before do
    VCR.use_cassette("slack_workspace") do
      @workspace = Workspace.new
    end
  end

  it "creates a list of channels and users" do
    VCR.use_cassette("slack_workspace") do
      expect(@workspace.channels.first).must_be_kind_of Channel
      expect(@workspace.users.first).must_be_kind_of User
    end
  end
end

describe "instance methods" do
  before do
    VCR.use_cassette("slack_workspace") do
      @workspace = Workspace.new
    end
  end

  it "returns text from print_details" do
    VCR.use_cassette("slack_workspace") do
      expect(@workspace.print_details("users")).must_be_kind_of Array
      expect(@workspace.print_details("channels")).must_be_kind_of Array
    end
  end

  it "returns a user object from select_user" do
    VCR.use_cassette("slack_workspace") do
      expect(@workspace.select_user("grace.m.shea")).must_be_kind_of User
      # expect(@workspace.select_user("123")).must_be_kind_of User
    end
  end

  it "returns text from print_details" do
    VCR.use_cassette("slack_workspace") do
      expect(@workspace.print_details("users")).must_be_kind_of Array
      expect(@workspace.print_details("channels")).must_be_kind_of Array
    end
  end

  it "returns a channel object from select_channel" do
    VCR.use_cassette("slack_workspace") do
      expect(@workspace.select_channel("random")).must_be_kind_of Channel
      # expect(@workspace.select_channel("456")).must_be_kind_of Channel
    end
  end

  it "returns channel details from show_details" do
    VCR.use_cassette("slack_workspace") do
      @workspace.select_channel("random")
      expect(@workspace.show_details).must_be_kind_of String

      @workspace.select_channel("random")
      expect(@workspace.show_details).must_be_kind_of String
    end
  end

  it "returns user details from show_details" do
    VCR.use_cassette("slack_workspace") do
      @workspace.select_user("grace.m.shea")
      expect(@workspace.show_details).must_be_kind_of String

      @workspace.select_channel("random")
      expect(@workspace.show_details).must_be_kind_of String
    end
  end
end

# describe "post message to slack" do
#   before do
#     VCR.use_cassette("slack_workspace") do
#       @workspace = Workspace.new
#     end
#   end

#   it "creates sends a message to a recipient" do
#     VCR.use_cassette("slack-posts") do
#       @workspace.select_channel.first
#       response = @workspace.send_message("should work")
#       expect(response["ok"]).must_equal true
#     end
#   end

it "raises an error for invalid channel" do
  VCR.use_cassette("slack-posts") do
    @workspace.select_channel("imaginary")
    expect { @workspace.send_message("shouldn't work") }.must_raise Recipient::SlackApiError
  end
end

#   it "raises an error for invalid user" do
#     VCR.use_cassette("slack-posts") do
#       @workspace.select_user.first
#       expect { workspace.send_message("shouldn't work") }.must_raise Recipient::SlackApiError
#     end
#   end
# end

require_relative "test_helper"

describe "User class" do
  let (:user_data) {
    {
      username: "shubharajan",
      real_name: "Shubha Rajan",
      slack_id: "ADSHF1324123",
    }
  }
  it "initializes a user class" do
    skip
    new_user = SlackCLI::User.new(user_data[:username],
                                  user_data[:real_name],
                                  user_data[:slack_id])

    expect(new_user).must_be_instance_of SlackCLI::User
  end

  it "has working reader methods" do
    skip
    new_user = SlackCLI::User.new(user_data[:username],
                                  user_data[:real_name],
                                  user_data[:slack_id])

    expect(new_user.username).must_equal user_data[:username]
    expect(new_user.username).must_equal user_data[:real_name]
    expect(new_user.username).must_equal user_data[:slack_id]
  end

  it "can display information about itself as a string" do
    skip
    new_user = SlackCLI::User.new(user_data[:username],
                                  user_data[:real_name],
                                  user_data[:slack_id])
    pretty_printed_string = "\nUsername : #{user_data[:username]}" +
                            "\nReal name : #{user_data[:real_name]}" +
                            "\nSlack ID : #{user_data[:slack_id]}"
    expect(new_user.display_details).must_equal pretty_printed_string
  end

  it "loads array of users from Slack's API" do
    skip
    VCR.use_cassette("list users") do
      users = SlackCLI::User.get_from_api
      expect(users).must_be_instance_of Array
      users.each do |user|
        expect(user).must_be_instance_of SlackCLI::User
      end
    end
  end
end

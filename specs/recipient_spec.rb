require "simplecov"
SimpleCov.start

require_relative "test_helper"
require_relative "../lib/recipient.rb"

# File always wants to make GET request to channel API regardless of @is_user status.
# Not sure how to make tests work for this.

# describe "Recipient class" do
#   before do
#     @is_user = true
#   end
#   it "Can get details about a user" do
#     slack_id = "USLACKBOT"
#     expect(Recipient.details(slack_id)).must_be_kind_of Hash
#   end
# end

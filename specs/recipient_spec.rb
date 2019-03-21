require_relative "test_helper"

# probably don't need any tests for abstract superclass.
# describe "Recipient" do
#   describe "initialize" do
#   end

#   describe "send message" do
#     it "can post a message on the everyone slack channel" do
#       VCR.use_cassette("message_post") do
#         name = "everyone"
#         text = "hello world"
#         pigeon = SlackCli::Recipient.send_message(name: name, message: text)

#         expect(pigeon["ok"]).must_equal true
#       end
#     end
#   end
# end

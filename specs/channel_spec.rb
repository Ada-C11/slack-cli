# require_relative "test_helper"

# describe "Channel Initialize" do
#   before do
#     @new_channel = Slack::Channel.new(
#       1,
#       "Ada_C11",
#       "api_discussion",
#     )
#   end

#   it "will create an instance of Channel" do
#     expect(@new_channel).must_be_instance_of Slack::Channel
#   end # it

#   describe "list channels method" do
#     it "can list all of the channels" do
#       VCR.use_cassette("list_channels") do
#         expect(Slack::Channel.channel_list).wont_be_nil
#         expect(Slack::Channel.channel_list).must_be_kind_of Array
#         expect(Slack::Channel.channel_list.length).must_equal 2
#       end # VCR
#     end # it

#     it "can tell how many members are in channels" do
#       VCR.use_cassette("list_channels") do
#         slack_channels = @new_channel
#         expect(@new_channel.channel_list["channels"]["members"]).must_be_kind_of Array

#         # expect(Slack::Channel.channel_list["members"].length).must_equal 2
#       end # VCR
#     end # it
#   end
# end # outer describe

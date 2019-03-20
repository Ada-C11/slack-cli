require_relative "test_helper"

describe "Channels" do
    describe "self.get" do
        it "will successfully get a response from Slack API for user list" do
            VCR.use_cassette("channel_information_find") do
                url = "http://slack.com/api/channels.list" 
                query =  {token: ENV["KEY"]}
                request = Slack::User.get(url, query)

                expect(request["ok"]).must_equal true
            end
        end
        it "will raise an exception if the GET request fails" do
                VCR.use_cassette("channel_information_find") do
                  url = "https://slack.com/api/channel.list"
                  query = {token: "dkdkdkdkdkdkd"}
          
                  expect {
                    Slack::User.get(url, query)
                  }.must_raise Slack::ResponseError
                end
              end
    end
end
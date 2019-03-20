 describe "self.get method" do 
    it "successfully returns users list HTTP response object" do 
      VCR.use_cassette("get_response") do 
        url = "https://slack.com/api/users.list"
        params = {
          token: ENV["SLACK_TOKEN"],
        }
        party_people = Channel.get

        expect(party_people["ok"]).must_equal true
      end
    end

    it "raises SlackError for inauthorization" do
      VCR.use_cassette("get_response") do 
        url = "https://slack.com/api/users.list"
        params = {
          token: "thisisbadtoken",
        }

        expect {
          Recipient.get(url, params)
        }.must_raise SlackError
      end
    end
  end
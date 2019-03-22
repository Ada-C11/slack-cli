require_relative "test_helper"

# probably don't need any tests for abstract superclass.
describe "Recipient" do
  before(:each) do
    VCR.insert_cassette("recipient/api_calls")
  end
  after(:each) do
    VCR.eject_cassette
  end

  describe "self.get"  do 
    describe "cases when our program should raise an exception..." do
      it "should raise an exception created by changes to API" do
        class Dummy < SlackCli::Recipient
          BADTOKEN = "123"

          def self.list_url
            return "http://slack.com/api/users.list"
          end

          def self.get
            query_params = {
              token: BADTOKEN,
            }
            response = HTTParty.get(list_url, query: query_params)
            return response
          end
        end
  
        test_dummy = Dummy.get
        expect(test_dummy["ok"]).must_equal false
        expect(test_dummy["error"]).must_equal "invalid_auth"
      end
  
      it "should raise an exception created by changes to API URL" do
        class Dummy < SlackCli::Recipient
          def self.list_url
             return "http://slack.com/api/users.lis"
          end
          def self.get
            super
            query_params = {
              token: TOKEN,
            }
          end
        end
  
        expect { Dummy.get }.must_raise SlackCli::SlackError
      end
    end
  end
end

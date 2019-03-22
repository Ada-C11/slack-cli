require_relative "test_helper"

# tests for abstract methods for classes

describe "cases when our program should raise an exception..." do
  before(:each) do
    VCR.insert_cassette("recipient_response")
  end
  after(:each) do
    VCR.eject_cassette
  end
  let(:workspace) {
    workspace = Workspace.new
  }

  it "should raise an exception created by changes to API" do
    class Dummy < SlackCli::Recipient
      LIST_URL = "http://slack.com/api/users.list"
      BADTOKEN = "123"
      def self.get
        query_params = {
          token: BADTOKEN,
        }
        response = HTTParty.get(self::LIST_URL, query: query_params)
        return response
      end
    end

    test_dummy = Dummy.get
    expect(test_dummy["ok"]).must_equal false
    expect(test_dummy["error"]).must_equal "invalid_auth"
  end

  it "should raise an exception created by changes to API URI" do
    class Dummy < SlackCli::Recipient
      LIST_URL = "http://slack.com/api/users.lis"
      def self.get
        query_params = {
          token: TOKEN,
        }
        response = HTTParty.get(self::LIST_URL, query: query_params)
        return response
      end
    end

    test_dummy = Dummy.get
    expect(test_dummy["ok"]).must_equal false
    expect(test_dummy["req_method"]).must_equal "users.lis"
  end



  # it "should raise an exception for bad POST token" do 
  #   class Dummy < SlackCli::Recipient
  #     MSG_URL = "https://slack.com/api/chat.postMessage"
  #     def self.post_message
  #       params = {
  #         token: "BADTOKEN",
  #         as_user: true,
  #         channel: name,
  #         text: message,
  #       }
  #       response = HTTParty.post(MSG_URL, body: params)
  #       return response
  #     end
  #   end

  #   test_dummy = Dummy.new
  #   expect(test_dummy.post_message("everyone", "test string")["ok"]).must_equal false
  #   expect(test_dummy["error"]).must_equal "invalid_auth"
  # end
end
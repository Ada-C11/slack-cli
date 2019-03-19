require_relative "test_helper"

describe SlackCLI::Recipient do
  describe 'constructor' do
    it 'takes and saves a Slack id and name' do
      VCR.use_cassette("recipient") do
        slack_id = "CH2SKTDBN"
        name = "random"
        record = SlackCLI::Recipient.new(slack_id, name)
        expect(record.slack_id).must_equal slack_id
        expect(record.name).must_equal name
        expect(record).must_be_kind_of SlackCLI::Recipient
      end
    end
  end
end
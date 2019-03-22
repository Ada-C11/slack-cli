require 'simplecov'
SimpleCov.start

require_relative 'test_helper'
require_relative '../lib/user.rb'

describe 'User class' do
  before do
    VCR.use_cassette('user_list') do
      @response = Slack::User.list
    end
  end

  it 'can retrieve a list of users' do
    expect(@response).must_be_kind_of Array
    expect(@response[0]).must_be_kind_of Slack::User
  end

  it 'can retrieve details of a specific user' do
    expect (@response[0].details).must_be_kind_of Hash
  end

  describe 'send_message to user' do
    it 'can send a message fine' do
      VCR.use_cassette('slack_post_user') do
        selected_user = @response[1]
        response = selected_user.send_message('This is our Test Msg to user!')
        expect(response).must_equal true
      end
    end

    it 'will raise an error when given an invalid channel' do
      VCR.use_cassette('slack-posts_user') do
        @response << Slack::User.new(
          name: 'Bogus',
          real_name: 'Bogus',
          slack_id: 'Bogus',
          status_text: 'Bogus',
          status_emoji: 'Bogus'
          )

          bogus_selected_user = @response.last

        exception = expect {
          bogus_selected_user.send_message('This post should not work')
        }.must_raise Slack::SlackApiError

        expect(exception.message).must_equal 'channel_not_found'
      end
    end
  end
end

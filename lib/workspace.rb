# workspace file for keeping all things slack 
require 'dotenv'
require 'httparty'

require_relative 'user'
require_relative 'channels'

Dotenv.load

module Slack
    class Workspace 
            URL = "https://slack.com/api/users.list"
            attr_reader :users, :channels, :selected
        
            def initialize 
                @users = Slack::User.list
                @channels = channels
                @selected = selected
            end

            def participants 
                participants = HTTParty.get(URL, query: {token: ENV["KEY"]})
            end

            def select_user(name) #return user or id/set the selected user
                #find user
                #set selected to user
                #return user 
                users.each do |user|
                    if name == user.name || name == user.slack_id
                end
                
            end

            def select_channel(channel_name_or_slack_id)

            end

            def show_details #currently_selected_recipient

            end

            def send_msg(message)
            
            end
    end
end
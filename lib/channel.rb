require 'httparty'
require 'awesome_print'
require 'dotenv'
Dotenv.load

class Channel
  def self.get_channels
    url = 'https://slack.com/api/channels.list'
    query_parameters = {
      token: ENV['SLACK_API_TOKEN']
    }
    
    response = HTTParty.get(url, query: query_parameters).to_s
    response = JSON.parse(response)

    return response["channels"]
  end
  
  def self.list_channels(channels)
    channels.each do |channel|
      puts channel["name"]
    end
  end

  def self.select_channel(channels)
    continue = true
    selected_channel = nil

    while(continue)
      ap "Select your channel with one of the following: "
      puts "a. channel name"
      puts "b. SlackID"
      puts "c. quit\n"
      print "> "
      select_channel_response = gets.chomp.downcase

      if select_channel_response == "a" || select_channel_response == "channel name"
        print "\nChannel name > "
        requested_channel_name = gets.chomp.downcase

        channels.each do |channel|
          if channel["name"] == requested_channel_name
            selected_channel = channel
          end
        end

        continue = false
        
      elsif select_channel_response == "b" || select_channel_response == "slackid"
        print "\nSlackID > "
        requested_id = gets.chomp.upcase

        channels.each do |channel|
          if channel["id"] == requested_id
            selected_channel = channel
          end
        end

        continue = false

      elsif select_channel_response == "c" || select_channel_response == "quit"
        continue = false
      else
        puts "Inaccurate response.\n\n"
      end
    end

    return selected_channel
  end
end
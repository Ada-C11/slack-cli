require 'httparty'
require 'awesome_print'
require 'dotenv'
Dotenv.load

class User
  def self.get_users
    url = 'https://slack.com/api/users.list'
    query_parameters = {
      token: ENV['SLACK_API_TOKEN']
    }
  
    response = HTTParty.get(url, query: query_parameters).to_s
    response = JSON.parse(response)

    return response["members"]
  end

  def self.list_users(users)
    users.each do |user|
      puts user["name"]
    end
  end

  def self.select_user(users)
    continue = true
    selected_user = nil

    while(continue)
      ap "Select your user with one of the following: "
      puts "a. username"
      puts "b. SlackID"
      puts "c. quit\n"
      print "> "
      select_user_response = gets.chomp.downcase

      if select_user_response == "a" || select_user_response == "username"
        print "\nUsername > "
        requested_username = gets.chomp.downcase

        users.each do |user|
          if user["name"] == requested_username
            selected_user = user
          end
        end
        
        continue = false

      elsif select_user_response == "b" || select_user_response == "slackid"
        print "\nSlackID > "
        requested_id = gets.chomp.upcase

        users.each do |user|
          if user["id"] == requested_id
            selected_user = user
          end
        end

        continue = false

      elsif select_user_response == "c" || select_user_response == "quit"
        continue = false
      else
        puts "Invalid response.\n\n"
      end
    end

    return selected_user
  end
end
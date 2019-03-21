# #!/usr/bin/env ruby
# require "dotenv"
# require "httparty"
# require "pry"
# require "awesome_print"
# Dotenv.load

# def main
#   puts "Welcome to the Ada Slack CLI!"

#   url = "https://slack.com/api/channels.list"

#   query_params = { token: ENV["API_KEY"] }

#   response = HTTParty.get(url, query: query_params)

#   response["channels"].each do |channel|
#     puts channel["name"]
#   end
#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME

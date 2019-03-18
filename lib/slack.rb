# #!/usr/bin/env ruby

# def main
#   puts "Welcome to the Ada Slack CLI!"

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME

require "dotenv"
require "httparty"

# Tell dotenv to look for the .env file
Dotenv.load

url = "https://slack.com/api/channels.list"

query = {
  token: ENV["KEY"],
}

response = HTTParty.get(url, query: query)

if response.message != 200
  raise ArgumentError, "Request is unsuccessful"
else
  puts "#{response}"
end

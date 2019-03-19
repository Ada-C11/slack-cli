require "httparty"
require "dotenv"
require "awesome_print"
require "pry"

Dotenv.load

BASE_URL = "https://slack.com/api/users.list"
query_parameters = {
  token: ENV["SLACK_API_TOKEN"],
}

response = HTTParty.get(BASE_URL, query: query_parameters)
ap ENV["SLACK_API_TOKEN"]

ap response
if (response.code == 200)
  response["members"].each do |user|
    puts user["name"]
  end
else
  puts "Error #{response.code} : #{response["message"]}"
end

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

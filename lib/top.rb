require "httparty"
require "dotenv"
require "table_print"
Dotenv.load

class Slack
  attr_reader :slack_id, :name

  #methods send_message(message)
  #self.get(url, params)
  #details
  #self.list

  query_parameters = {
    token: ENV["SLACK_API_TOKEN"],
    pretty: 1,
  }
  url = "https://slack.com/api/conversations.list?"
  @channels = HTTParty.get(url, query: query_parameters)
  # puts @channels
  url2 = "https://slack.com/api/users.list?"
  @users = HTTParty.get(url2, query: query_parameters)
  # loads_info
  puts "there are #{@channels["channels"].length} channels and #{@users["members"].length}"
  # puts channels["channels"][0]["name"]

  def lists_channels
    @channels["channels"].each do |x|
      puts "name: #{x["name"]}"
      puts "topic: #{x["topic"]["value"]}"
      puts "number of members: #{x["num_members"]}"
      puts "slack id: #{x["id"]}"
    end
  end

  def lists_users
    @users["members"].each do |x|
      puts "name: #{x["name"]}"
      puts "id: #{x["id"]}"
      puts "real name: #{x["real_name"]}"
    end
  end

  def options
    puts "What should we do next? (list channels/ list users/ quit):"
    return gets.chomp.downcase
  end

  continue = true

  while (continue)
    response = options
    case response
    when "list channels"
      lists_channels
    when "list users"
      lists_users
    when "quit"
      continue = false
    end
  end
end

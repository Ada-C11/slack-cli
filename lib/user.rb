require "awesome_print"
require_relative "recipient"

module Slack  
  class User < Recipient
    BASE_URL = "https://slack.com/api/users.list"
    PARAMETER = {token: ENV["SLACK_API_TOKEN"]}

    attr_reader :real_name, :status_text

    def initialize(name, slack_id, real_name)
      super(name, slack_id)
       @real_name = real_name
    end

    def self.list
      user_data = self.get(BASE_URL, PARAMETER)
      # user_data = user["members"].map do |user|
      #     { username: user["name"],
      #      real_name: user["real_name"],
      #      slack_id: user["id"] }
      #   end
      #   return user_data
      user_data["members"].map do |user|
        self.new(user["id"], user["name"], user["profile"]["real_name"])
      end
    
    end

    def details
      super << "real_name"
    end
  end
end





# module Slack
#   class User
#     USER_URL = "https://slack.com/api/users.list"

#     class SlackError < StandardError; end

#     Dotenv.load

#     attr_reader :username, :real_name, :slack_id

#     def initialize(username:, real_name:, slack_id:)
#       @username = username
#       @real_name = real_name
#       @slack_id = slack_id
#     end # initialize

#     def self.get_user_data
#       query_parameters = {
#         token: ENV["SLACK_API_TOKEN"],
#       }

#       response = HTTParty.get(USER_URL, query: query_parameters)

#       if response.code == 200
#         user_data = response["members"].map do |user|
#           { username: user["name"],
#            real_name: user["real_name"],
#            slack_id: user["id"] }
#         end
#         return user_data
#       else
#         raise Slack::SlackError, "There was an error. #{response.error}: #{response.message}"
#       end # if
#     end

#     def self.list_users
#       users = get_user_data

#       return users
#     end

#     def self.select_user(name_or_id)
#       user_data = get_user_data
#       chosen_user = nil

#       user_data.each do |user|
#         if user[:username] == name_or_id
#           chosen_user = Slack::User.new(
#             username: user[:username],
#             real_name: user[:real_name],
#             slack_id: user[:slack_id],
#           )
#         elsif user[:real_name] == name_or_id
#           chosen_user = Slack::User.new(
#             username: user[:username],
#             real_name: user[:real_name],
#             slack_id: user[:slack_id],
#           )
#         end
#       end

#       if chosen_user == nil
#         raise Slack::SlackError, "There was an error. #{response.error}: #{response.message}"
#       end

#       return chosen_user
#     end

#     def show_details(name_or_id)
#       user_details = User.select_user(name_or_id)

#       details = {
#         "Username" => user_details.username,
#         "Real Name" => user_details.real_name,
#         "Slack ID" => user_details.slack_id
#       }
#       return details
#     end
#   end # class
# end # module

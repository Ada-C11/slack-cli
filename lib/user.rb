

module SlackBot
  class User < Recipient
    USER_LIST_URL = "https://slack.com/api/users.list?"
    TOKEN = ENV["TOKEN"]
    def self.list
      query_parameters = { token: TOKEN }
      response = HTTParty.get(USER_LIST_URL, query: query_parameters)
      # Check_Error_Status(response)

      users_array = response["members"].map do |user|
        {
          real_name: user["real_name"],
          name: user["name"],
          id: user["id"],
        }
      end
      return users_array
    end
  end
end

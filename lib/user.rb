module SlackCLI
  class User
    attr_reader :name, :id
    USER_URL_MESSAGE = "https://slack.com/api/"
    API_KEY = ENV["SLACK_API_TOKEN"]

    def initialize(name, id)
      @name = name
      @id = id
    end

    def self.get(url, param)
      query = {token: param}
      @response = HTTParty.get(url, query: query)
      return @response
    end

    def self.list
      list_fields = ["name", "real_name", "id"]
      type = "members"
      members = @response[type]
      formatted_list = []
      members.each do |member|
        hash = {}
        list_fields.each do |field|
          hash["#{field}"] = member[field]
        end
        formatted_list << hash
      end
      return formatted_list
    end

    def self.details(parameter_to_find)
      members_info = @response["members"]
      members_info.each do |member|
        if member["name"] == parameter_to_find || member["id"] == parameter_to_find
          details =
            "\n\nThe user's real name is: #{member["real_name"]}
            Occupation: #{member["profile"]["title"]}
            Status: #{member["profile"]["status_text"]}
            Team id is: #{member["team_id"]}
            Contact Information:
                Phone number -> #{member["profile"]["phone"]} 
                Skype -> #{member["profile"]["skype"]}\n\n"

          return details
        end
      end
      raise ArgumentError, "The user you are trying to find does not exist"
    end

    def self.message(text, user)
      response = HTTParty.post(
        "#{USER_URL_MESSAGE}chat.postMessage",
        headers: {"Content-Type" => "application/x-www-form-urlencoded"},
        body: {
          token: API_KEY,
          channel: user,
          text: text,
        },
      )
      if response["ok"]
        return true
      else
        raise ArgumentError, "Error when sending  message to #{user}."
      end
    end
  end
end

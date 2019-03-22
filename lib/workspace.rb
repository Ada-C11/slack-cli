require_relative "recipient"
require "httparty"

module SlackAPI
  class Workspace
    def select_channel(identifier)
      response = Recipient.get("channels.list")

      selected_channel = ""
      response["channels"].each do |channel|
        if channel["id"] == identifier
          selected_channel = identifier
        elsif channel["name"] == identifier
          selected_channel = identifier
        end
      end
      if selected_channel == ""
        raise SlackAPI::SlackError, "That is not a vaild channel"
      end
      return selected_channel
    end

    def see_channel_details(identifier)
      response = Recipient.get("channels.list")

      channel_details = []

      response["channels"].each do |channel|
        if channel["id"] == identifier || channel["name"] == identifier
          channel_details << { "name" => channel["name"], "topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"] }
          return channel_details
        end
      end
    end

    def select_user(identifier)
      response = Recipient.get("users.list")

      selected_user = ""

      response["members"].each do |member|
        if member["id"] == identifier
          selected_user = member["id"]
        elsif member["name"] == identifier
          selected_user = member["id"]
        end
      end
      if selected_user == ""
        raise SlackAPI::SlackError, "That is not a valid user"
      end
      return selected_user
    end

    def see_user_details(identifier)
      response = Recipient.get("users.list")

      user_details = []

      response["members"].each do |member|
        if member["id"] == identifier || member["name"] == identifier
          user_details <<
            { "name" => member["name"],
             "real name" => member["real_name"],
             "slack id" => member["id"] }

          return user_details
        end
      end
    end
  end # end of class
end # end of module

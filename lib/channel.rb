require_relative "recipient"

class Channel < Recipient
  attr_reader
  LIST_URL = "https://slack.com/api/channels.list"

  def initialize
    @topic
    @member_count
  end

  def self.list
    query_params = {
      token: TOKEN,
    }
    
    channels_json = Channel.get(query: query_params)

   list_of_channels = channels_json["channels"].select { |channel| channel["name"] }
    return list_of_channels
  end

  def details(name)
    list.each do |channel|
      if channel["name"] == name
        puts channel["purpose"]["value"]
      end
    end
  end
end

test = HTTParty.get("https://slack.com/api/channels.list?token=xoxp-581967218119-580781269267-579777948256-23a22653dd928edbcbe9830d05729d53")
binding.pry

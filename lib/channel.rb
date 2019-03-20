require_relative "recipient"

class Channel < Recipient
  attr_reader
  LIST_URL = "https://slack.com/api/channels.list"

  def initialize
    @topic
    @member_count
  end

  def self.list
    channels_json = Channel.get

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

test = Channel.get
binding.pry

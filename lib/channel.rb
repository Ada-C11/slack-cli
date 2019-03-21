require 'table_print'
require "httparty"
require "dotenv"

class Channel
  # @topic = topic
  # @member_count = member_count

  def initialize(channel_map)
    @id = channel_map['id']
    @topic = channel_map['topic']['value']
    @member_count = channel_map['num_members']
    @name = channel_map['name']
  end

  # def details
  #   #code here
  # end
  #
  # def self.list
  #   #code here
  # end
end

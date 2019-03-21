require_relative "slack"
require_relative "top"
require "httparty"
require "dotenv"
require "table_print"
Dotenv.load

class Channel
  attr_reader :real_name,
    def lists_channels
      @channels["channels"].each do |x|
        puts x["name"]
      end
    end
end

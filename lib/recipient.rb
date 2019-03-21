require "httparty"
require "dotenv"
Dotenv.load

class Recipient
  TOKEN = ENV["SLACK_TOKEN"]

  def initialize(id, name)

    @id = id
    @name = name
  end

# def self.list
#   raise NotImplemented Error
# end



end

require 'dotenv'
require 'httparty'
Dotenv.load

class Recipient
  @slack_id = slack_id
  @name = name

  def send_message(message)
    #code here
  end

  # def self.get(url, params)
  #   #code here
  # end

  def details
    raise 'Please implement me'
  end

  def self.list
    raise 'Please implement me'
  end
end

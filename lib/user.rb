require 'httparty'

class User < Recipient
  
  attr_reader :real_name
  
  def initialize
    super(slack_id, name)
    @real_name
  end
  
  

end
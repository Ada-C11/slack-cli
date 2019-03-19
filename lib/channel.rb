require "httparty"
require "env"
Dotenv.load

class Channel
  attr_reader :name, :topic, :member_count, :id

  def initialize
    @name = name
    @topic = topic
    @member_count = member_count #some code that counts users.
    @id = id
  end

  def details(name, topic, member_count, id)
  end

  def self.list
  end
end

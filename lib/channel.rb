# require_relative "slack"
require "httparty"
require "dotenv"
require "table_print"
Dotenv.load

class Channel
  attr_reader :name, :topic, :num_members, :slack_id

  def initialize(name, topic, num_members, slack_id)
    @name = name
    @topic = topic
    @num_members = num_members
    @slack_id = slack_id
  end

  def details
    puts "name: #{name}"
    puts "topic: #{topic}"
    puts "number of members: #{num_members}"
    puts "slack id: #{slack_id}"
  end
end

class User
  attr_accessor :username, :real_name, :id
  def initialize(user_map)
    @username = user_map['name']
    @real_name = user_map['real_name']
    @id = user_map['id']
    # @status_text = user_map['status_text']
    # @status_emoji = user_map['status_emoji']
  end

  # def details do
  #   #code here
  # end
  #
  # def self.list
  #   #code here
  # end

  def to_s
    "Username: #{@username}, Real name: #{@real_name}, Slack ID: #{@id}"
  end
end

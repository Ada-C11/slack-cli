class User
  def initialize(user_map)
    @username = user_map['display_name']
    @real_name = user_map['real_name']
    @slack_id = user_map['id']
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
end

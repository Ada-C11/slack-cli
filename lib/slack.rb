require_relative 'workspace'

#driver code
def main
  workspace = Workspace.new
  puts "TatiHana Slack Channels loaded #{SlackCli::Channel.list.length} channels"
  puts "TatiHana Users loaded #{SlackCli::User.list.length} users"

  def options
    puts "Please choose one of the following options:
    - list users
    - list channels
    - select user
    - select channel
    - details
    - send message
    - quit
    Enter your choice now:"
    # selected = false
  end

  options
  choice = gets.chomp

  loop do
    case choice
    when "list users"
      puts workspace.list_users
    when "list channels"
      puts workspace.list_channels
    when "select user"
      puts "what user would you like to select?"
      selected_user = gets.chomp
      workspace.select_user(selected_user)
    when "select channel"
      puts "What channel would you like to select?"
      selected_channel = gets.chomp
      workspace.select_channel(selected_channel)
    when "details"
      puts "Details for #{workspace.selected.name}..."
      workspace.show_details
    when "send message"
      workspace.send_messagea
    when "quit"
      puts "Thanks for checking out TatiHana! Bye bye..."
      exit
    else
      puts "Invalid option! :("
    end

    options
    choice = gets.chomp
  end
end

main if __FILE__ == $0

# puts "Welcome to the Ada Slack CLI!"
# puts "We currently have #{User.list.length} members and #{Channel.list.length} channels."

puts ""
puts "Please choose one of the the following number options"
puts "1. List Users"
puts "2. List Channels"
puts "3. Select User"
puts "4. Select Channel"
puts "5. Quit"

selection = gets.chomp

loop do
  case selection
  when "1"
    puts "Here is the list of users:"
    # puts User.list
  when "2"
    puts "Here is the list of channels: "
    # puts Channel.list
  when "3"
    chose_user = gets.chomp
    workspace = Workspace.new
    # puts workspace.show_details_user(chose_user)
  when "4"
    chose_channel = gets.chomp
    workspace = Workspace.new
    # puts workspace.show_details_channel(chose_channel)
  when "5"
    break
  end
end

puts "Please choose one of the the following number options"
puts "1. List Users"
puts "2. List Channels"
puts "3. Quit"

selection = gets.chomp

loop do
  if selection == "1"
    puts "Here is the list of users:"
    # puts User.list
  elsif selection == "2"
    puts "Here is the list of channels: "
    # puts Channel.list
  else
    break
  end
end

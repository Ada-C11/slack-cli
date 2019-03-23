require_relative "./workspace"

class SlackCLI
  def initialize(api_token)
    @commands = {
      'list users' => self.method(:list_users),
      'list channels' => self.method(:list_channels),
      'select user' => self.method(:select_user),
    'select channel' => self.method(:select_channel),
      'exit' => self.method(:quit),
      'quit' => self.method(:quit),
    }
    @time_to_go = false
    @workspace = Workspace.new(api_token)
  end

  def quit
    @time_to_go = true
  end

  def list_users
    puts @workspace.users
  end

  def list_channels
    puts @workspace.channels
  end

  def select_user
    print "which user? "
    user = gets.chomp
    selected_user = @workspace.select_user(user)
    if selected_user.nil?
      puts "thats not a user try again"
    end
  end

  def select_channel
    print "which channel? "
    channel = gets.chomp
    selected_channel = @workspace.select_channel(channel)
    if selected_channel.nil?
      puts "thats not a user try again"
    end
  end

  def run
    while !@time_to_go do
      puts "Please enter one of the available commands: #{@commands.keys}"
      print 'Command: '
      command = gets.chomp
      if @commands.key? command
        @commands[command].call
      else
        puts 'You silly goose! That is no command!'
      end
    end
    puts 'Toodles!'
  end
end

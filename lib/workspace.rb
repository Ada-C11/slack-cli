# workspace file for keeping all things slack 
require 'dotenv'
require 'httparty'    

Dotenv.load

class Workspace 
        URL = "https://slack.com/api/users.list"
        attr_reader :user, :channels, :selected
       
        # def initialize 
        #     @user = user
        #     @channels = channels
        #     @selected = selected
        # end

        def participants 
            participants = HTTParty.get(URL, query: {token: ENV["KEY"]})
        end
        
    end


    slack = Workspace.new 
    puts slack.participants

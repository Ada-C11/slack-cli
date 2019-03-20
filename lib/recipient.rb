module SlackBot
  class Recipient
    def self.list
      raise NotImplementedError
    end
    
    def Check_Error_Status(response)
        binding.pry
        if response.code != 200
            raise SlackApiError, "#{reponse.code} Error: #{response.message}"
        end
    end
  end
end

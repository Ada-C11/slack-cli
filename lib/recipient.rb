module SlackAPI
  class Recipient
    def api_wrapper
    end

    BASE_URL = "https://slack.com/api/"

    def self.list(recipient, sub_url)
      query = {
        token: ENV["SLACK_API_TOKEN"],
      }

      response = HTTParty.get("#{BASE_URL}#{sub_url}", query: query)

      return response
      # iterate through recipient depending on if it is user or channel
    end

    def self.select(identifier)
      raise NotImplementedError, "Implement me in a child class"
    end

    def self.see_details(identifier)
      raise NotImplementedError, "Implement me in a child class"
    end
  end
end

module SlackBot
  class SlackApiError < StandardError; end

  class Recipient
    BASE_URL = "https://slack.com/api/"
    TOKEN = ENV["TOKEN"]
    def self.list
      raise NotImplementedError
    end

    def details
      raise NotImplementedError
    end

    def send_message(message)
      body = {
        text: message,
        channel: id,
        token: TOKEN,
      }
      response = HTTParty.post("#{BASE_URL}chat.postMessage", body: body, headers: { "Content-type" => "application/x-www-form-urlencoded" })
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when posting #{message} to #{id}, error: #{response.parsed_response["error"]}"
      end

      return true
    end

    def self.check_response_code(response)
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when posting #{message} to #{id}, error: #{response.parsed_response["error"]}"
      end
    end

    private

    def self.get(path_url)
      query_parameters = { token: TOKEN }
      response = HTTParty.get("#{BASE_URL}#{path_url}", query: query_parameters)
      return response
    end
  end
end

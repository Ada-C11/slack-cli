module SlackCLI
  class Recipient
    attr_reader :id, :name, :response

    def initialize(id, name)
      @id = id
      @name = name
      @response = response
      @user_params = ""
    end

    def self.get_response(url, param)
      query = { token: param }
      @response = HTTParty.get(url, query: query)
    end

    def self.list(key_words)
      members_list = []
      ["members"].each do |member|
        key_words.each do |parameter, value|
        members_list << {parameter => value}
        end
      end
      return members_list
    end
    end
  end

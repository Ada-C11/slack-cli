module SlackCLI
  class Recipient
    attr_reader :id, :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def self.get_response(url, param)
      query = {token: param}
      response = HTTParty.get(url, query: query)
    end
  end
end

module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def headers
      {
        'Accept' => 'application/json',
        'Content-Type' => "application/json"
      }
    end
  end
end

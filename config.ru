ENV['RACK_ENV'] ||= "development"

if ENV['RACK_ENV'] == "development"
  require 'pry'
end

module EvilRack
  class App
    def call(env)
      request = Rack::Request.new(env)
      body = JSON.parse(request.body.read)

      response = {
        test: 'test test test'
      }

      [200, {"Content-Type" => "application/json"}, [response.to_json]]
    end
  end
end

run EvilRack::App.new

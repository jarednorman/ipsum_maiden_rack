ENV['RACK_ENV'] ||= "development"

require 'json'
require 'ipsum_maiden'

if ENV['RACK_ENV'] == "development"
  require 'pry'
else
  require 'raven'
  use Raven::Rack
end

module IpsumMaidenRack
  class App
    def call(env)
      request = Rack::Request.new(env)
      body = JSON.parse(request.body.read)

      type = body.fetch("type")
      raise unless type.is_a? String
      raise unless %w(sentences paragraphs).include? type

      count = body.fetch("count")
      raise unless count.is_a? Integer

      result =
        if type == "sentences"
          IpsumMaiden.sentences(count)
        elsif type == "paragraphs"
          IpsumMaiden.paragraphs(count)
        end

      [200, {"Content-Type" => "application/json"}, [{
        result: result
      }.to_json]]
    end
  end
end

run IpsumMaidenRack::App.new

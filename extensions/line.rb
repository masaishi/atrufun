require 'net/http'
require 'uri'

class Line
  TOKEN = ENV['LINE_TOKEN']
  URI = URI.parse("https://notify-api.line.me/api/notify")

  def make_request(msg)
    request = Net::HTTP::Post.new(URI)
    request["Authorization"] = "Bearer #{TOKEN}"
    request.set_form_data(message: msg)
    request
  end

  def send(msg)
    request = make_request(msg)
    response = Net::HTTP.start(URI.hostname, URI.port, use_ssl: URI.scheme == "https") do |https|
      https.request(request)
    end
  end
end
def line_send(text)
  line = Line.new
  res = line.send(text)
  res.code
  res.body
end

require 'net/http'
require 'uri'
require 'json'

ips = []
logins = []

50.times { ips << FFaker::Internet.unique.ip_v4_address }
100.times { logins << FFaker::Name.unique.name }

200_000.times do
    params = {
        post: {
            title: FFaker::Book.title,
            body: FFaker::Tweet.body,
            login: logins.sample,
            ip: ips.sample
        }
    }

    header = { 'Content-Type': 'application/json' }
    uri = URI.parse('http://localhost:3000/api/v1/posts')

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri, header)
    request.body = params.to_json
    http.request(request)
end

10_000.times do |i|
  params = { review: { mark: rand(1..5) } }

  header = { 'Content-Type': 'application/json' }
  uri = URI.parse("http://localhost:3000/api/v1/posts/#{i + 1}/reviews")

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri, header)
  request.body = params.to_json
  http.request(request)
end
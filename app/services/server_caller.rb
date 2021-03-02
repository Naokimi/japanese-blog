class ServerCaller < ApplicationService
  def initialize(verb, url, args = {})
    prefix = Rails.env == 'production' ? 'https://frozen-fjord-08094.herokuapp.com/' : 'http://localhost:4000/'
    @verb = verb
    @url = URI(prefix + url)
    @args = args
  end

  def call
    res = case @verb
          when 'get'
            Net::HTTP.get(@url)
          when 'post'
            post_request
          end
    JSON.parse(res)
  rescue Errno::ECONNREFUSED
    {}
  end

  private

  def post_request
    req = Net::HTTP::Post.new(@url, 'Content-Type' => 'application/json')
    req.body = @args.to_json
    response = Net::HTTP.start(@url.hostname, @url.port) do |http|
      http.request(req)
    end
    response.body
  end
end

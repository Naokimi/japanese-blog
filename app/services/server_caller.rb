class ServerCaller < ApplicationService
  def initialize(verb, url, args = {})
    prefix = 'http://localhost:4000/'
    @verb = verb
    @url = URI(prefix + url)
    @args = args
  end

  def call
    res = case @verb
          when 'get'
            Net::HTTP.get(@url)
          when 'post'
            Net::HTTP.post_form(@url, @args)
          end
    JSON.parse(res)
  end
end

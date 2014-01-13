module SpBus
  class Connection

    def initialize
      @cookiejar ||= HTTP::CookieJar.new
    end

    def get(*args)
      perform(:get, *args)
    end

    def post(*args)
      perform(:post, *args)
    end

    private

    def perform(method, uri, params = {})
      @url = URI.join(SpBus.endpoint, uri).to_s
      @response = HTTParty.send(method, @url, :query => params, :headers => request_headers)

      check_response
      store_cookies

      @response
    end

    def request_headers
      cookies = HTTP::Cookie.cookie_value(@cookiejar.cookies(@url))

      headers = { "Accept" => "application/json" }
      headers = headers.merge("Cookie" => cookies) unless cookies.empty?
      headers
    end

    def check_response
      raise HTTPError unless @response.code == 200
    end

    def store_cookies
      headers = @response.headers.get_fields("set-cookie")
      headers.each { |v| @cookiejar.parse(v, @url) } if headers
    end
  end
end

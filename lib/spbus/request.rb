module SpBus
  class Request

    AUTH_URL = "http://olhovivo.sptrans.com.br/"

    attr_writer :authenticated

    def initialize(url)
      @url = url
      @authenticated = true
    end

    def get
      get_cookies if @authenticated
      open(@url, request_headers).read
    end

    private

    def get_cookies
      @cookies = open(AUTH_URL).meta["set-cookie"]
    end

    def request_headers
      headers = {}
      headers["Cookie"] = @cookies if @authenticated
      headers
    end
  end
end


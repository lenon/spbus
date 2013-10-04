module SpBus
  class Request

    AUTH_URL = "http://olhovivo.sptrans.com.br/"

    attr_writer :authenticated

    def initialize(url)
      @url = url
      @authenticated = true
    end

    def get
      tries ||= 3
      get_cookies if @authenticated
      open(@url, request_headers).read
    rescue Errno::ETIMEDOUT => e
      raise e if (tries -= 1) == 0
      retry
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


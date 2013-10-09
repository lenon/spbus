module SpBus
  class Request

    def initialize(url)
      @url = url
    end

    def get
      tries ||= 3
      open(@url, request_headers).read
    rescue Errno::ETIMEDOUT => e
      raise e if (tries -= 1) == 0
      retry
    end

    private

    def request_headers
      headers = {}
      headers["User-Agent"] = "SpBus/#{SpBus::VERSION}"
      headers
    end
  end
end


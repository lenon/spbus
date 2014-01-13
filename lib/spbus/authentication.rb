module SpBus
  class Authentication

    def initialize(connection, token)
      @connection = connection
      @token = token
    end

    def authorize
      response = @connection.post("Login/Autenticar", :token => @token)
      unless response.body == "true"
        raise AuthenticationError
      end
      true
    end
  end
end

module CustomHelpers

  def use_cassette(name, options = {})
    VCR.use_cassette(name, options) { yield }
  end

  def authorized_connection
    connection = SpBus::Connection.new
    use_cassette(:successful_authentication) do
      SpBus::Authentication.new(connection, SpecEnv.valid_api_token).authorize
    end
    connection
  end
end

require "spec_helper"

describe SpBus::Authentication do

  let(:token) { SpecEnv.valid_api_token }
  let(:connection) { SpBus::Connection.new }

  subject { described_class.new(connection, token) }

  describe "#authorize" do

    context "when API token is valid" do
      it "returns true" do
        use_cassette(:successful_authentication) do
          expect(subject.authorize).to be true
        end
      end
    end

    context "when API token is not valid" do

      let(:token) { SpecEnv.invalid_api_token }

      it "raises an error" do
        use_cassette(:unsuccessful_authentication) do
          expect {
            subject.authorize
          }.to raise_error(SpBus::AuthenticationError)
        end
      end
    end
  end
end

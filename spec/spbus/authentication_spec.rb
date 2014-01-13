require "spec_helper"

describe SpBus::Authentication do

  let(:connection) { SpBus::Connection.new }
  subject { described_class.new(connection, sptrans_token) }

  describe "#authorize" do

    context "token is valid" do
      it "returns true" do
        use_cassette(:successful_authentication) do
          expect(subject.authorize).to be true
        end
      end
    end

    context "token is invalid" do
      subject { described_class.new(connection, sptrans_invalid_token) }

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

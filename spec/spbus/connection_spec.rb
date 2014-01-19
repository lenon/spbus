require "spec_helper"

describe SpBus::Connection do

  describe "#get" do

    context "when GET request is successful" do
      before do
        use_cassette(:successful_authentication) do
          subject.post("Login/Autenticar", :token => SpecEnv.valid_api_token)
        end
      end

      it "returns the response object" do
        use_cassette(:successful_get_request) do
          expect(subject.get("Corredor", :foo => "bar")).to respond_to(:body)
        end
      end
    end

    context "when GET request is not successful" do
      it "raises an error" do
        use_cassette(:unsuccessful_get_request) do
          expect {
            subject.get("Banana")
          }.to raise_error(SpBus::HTTPError)
        end
      end
    end
  end

  describe "#post" do
    context "when POST request is successful" do
      it "returns the response object" do
        use_cassette(:successful_authentication) do
          expect(
            subject.post("Login/Autenticar", :token => SpecEnv.valid_api_token)
          ).to respond_to(:body)
        end
      end
    end

    context "when POST request is not successful" do
      it "raises an error" do
        use_cassette(:unsuccessful_post_request) do
          expect {
            subject.post("Banana")
          }.to raise_error(SpBus::HTTPError)
        end
      end
    end
  end

  describe "cookies management" do

    context "first request sent" do
      it "does not send cookies" do
        options = hash_including(:headers => hash_excluding("Cookie" => anything))

        expect(HTTParty).to receive(:post).with(anything, options).and_call_original

        use_cassette(:successful_authentication) do
          subject.post("Login/Autenticar", :token => SpecEnv.valid_api_token)
        end
      end
    end

    context "last response came with cookies" do
      before do
        use_cassette(:successful_authentication) do
          subject.post("Login/Autenticar", :token => SpecEnv.valid_api_token)
        end
      end

      it "store cookies to send with the next request" do
        cookie = regexp_matcher(/^apiCredentials=[0-9a-z]{416}$/i)
        options = hash_including(:headers => hash_including("Cookie" => cookie))

        expect(HTTParty).to receive(:get).with(anything, options).and_call_original

        use_cassette(:successful_get_request) do
          subject.get("Corredor", :foo => "bar")
        end
      end
    end
  end
end

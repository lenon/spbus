require "spec_helper"

describe SpBus::Connection do

  describe "#get" do

    context "successful GET request" do
      before do
        use_cassette(:successful_authentication) do
          subject.post("Login/Autenticar", :token => sptrans_token)
        end
      end

      it "returns the response" do
        use_cassette(:successful_get_request) do
          expect(subject.get("Corredor", :foo => "bar")).to respond_to(:body)
        end
      end
    end

    context "unsuccessful GET request" do
      it "raises an error" do
        use_cassette(:unsuccessful_get_request) do
          expect {
            subject.get("Banana")
          }.to raise_error(SpBus::HTTPError)
        end
      end
    end

    context "cookies management" do
      before do
        use_cassette(:successful_authentication) do
          subject.post("Login/Autenticar", :token => sptrans_token)
        end
      end

      it "store cookies between requests" do
        use_cassette(:successful_get_request) do
          expect {
            subject.get("Corredor", :foo => "bar")
          }.to_not raise_error
        end
      end
    end
  end

  describe "#post" do

    context "successful POST request" do
      it "returns the response" do
        use_cassette(:successful_authentication) do
          expect(
            subject.post("Login/Autenticar", :token => sptrans_token)
          ).to respond_to(:body)
        end
      end
    end

    context "unsuccessful POST request" do
      it "raises an error" do
        use_cassette(:unsuccessful_post_request) do
          expect {
            subject.post("Banana")
          }.to raise_error(SpBus::HTTPError)
        end
      end
    end
  end
end

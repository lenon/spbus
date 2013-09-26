require "spec_helper"

describe SpBus::Request do

  describe "#get" do

    context "authenticated request", vcr: { cassette_name: "auth_request" } do

      subject { described_class.new("http://olhovivo.sptrans.com.br/v0/Linha/Buscar?termosBusca=6400-10") }

      it "does not raise any error when fetching an authenticated resource" do
        expect {
          subject.get
        }.to_not raise_error
      end

      it "returns expected content" do
        expect(subject.get).to match(/CodigoLinha/)
      end
    end

    context "unauthenticated request", vcr: { cassette_name: "normal_request" } do

      subject { described_class.new("http://200.99.150.170/PlanOperWeb/linhaselecionada.asp?Linha=6450-10") }
      before { subject.authenticated = false }

      it "does not raise any error" do
        expect {
          subject.get
        }.to_not raise_error
      end

      it "returns expected content" do
        expect(subject.get).to match(/Selecione abaixo o resultado desejado/)
      end
    end
  end
end


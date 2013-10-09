require "spec_helper"

describe SpBus::Request do

  describe "#get", vcr: { cassette_name: "simple_request" } do

    subject { described_class.new("http://200.99.150.170/PlanOperWeb/linhaselecionada.asp?Linha=6450-10") }

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


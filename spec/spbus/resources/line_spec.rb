require "spec_helper"

describe SpBus::Line do

  describe "#sign" do
    subject do
      described_class.new(:DenominacaoTPTS => "destino",
                          :DenominacaoTSTP => "origem",
                          :Sentido         => direction)
    end

    context "line is going from origin to destination" do
      let(:direction) { 1 }

      it "returns destination_sign value" do
        expect(subject.sign).to eql("destino")
      end
    end

    context "line is going from destination to origin" do
      let(:direction) { 2 }

      it "returns origin_sign value" do
        expect(subject.sign).to eql("origem")
      end
    end
  end

  describe "#trip_id" do
    subject do
      described_class.new(:Letreiro => "6450",
                          :Tipo     => "10",
                          :Sentido  => 2)
    end

    it "returns the trip id" do
      expect(subject.trip_id).to eql("6450-10-1")
    end
  end
end

require "spec_helper"

describe SpBus::Line do

  describe "#sign" do
    before do
      allow(subject).to receive(:destination_sign) { "destino" }
      allow(subject).to receive(:origin_sign) { "origem" }
      allow(subject).to receive(:direction) { direction }
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
    before do
      allow(subject).to receive(:number) { "6450" }
      allow(subject).to receive(:kind) { "10" }
      allow(subject).to receive(:direction) { 2 }
    end

    it "returns the trip id" do
      expect(subject.trip_id).to eql("6450-10-1")
    end
  end
end

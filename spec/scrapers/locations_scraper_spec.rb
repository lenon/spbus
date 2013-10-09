require "spec_helper"

describe SpBus::Scrapers::Locations do

  describe "#fetch", vcr: { cassette_name: "buses_locations" } do

    subject { described_class.new(32827) }
    before { subject.fetch }

    it "creates a Bus object for every position" do
      expect(subject.buses).to have(7).item
      expect(subject.buses.first).to be_kind_of(SpBus::Bus)
    end

    it "sets bus latitude" do
      expect(subject.buses.first.latitude).to eql(-23.576496125)
    end

    it "sets bus longitude" do
      expect(subject.buses.first.longitude).to eql(-46.67068125)
    end
  end
end


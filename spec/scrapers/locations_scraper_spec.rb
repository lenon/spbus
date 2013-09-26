require "spec_helper"

describe SpBus::Scrapers::Locations do

  describe "#fetch", vcr: { cassette_name: "buses_locations" } do

    subject { described_class.new(32827) }
    before { subject.fetch }

    it "creates a Bus object for every position" do
      expect(subject.buses).to have(3).item
      expect(subject.buses.first).to be_kind_of(SpBus::Bus)
    end

    it "sets bus latitude" do
      expect(subject.buses.first.latitude).to eql(-23.604221250000002)
    end

    it "sets bus longitude" do
      expect(subject.buses.first.longitude).to eql(-46.6749935)
    end
  end
end


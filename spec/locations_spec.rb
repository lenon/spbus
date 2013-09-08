require "spec_helper"

describe SpBus::Locations do

  describe "#fetch_locations", :vcr do

    subject { described_class.new("59") }
    before { subject.fetch_locations }

    it "retrieves all buses locations" do
      expect(subject.buses).to have(1).item
      expect(subject.buses.first).to be_kind_of(SpBus::Bus)
      expect(subject.buses.first.lat).to eql(-23.64352625)
      expect(subject.buses.first.long).to eql(-46.735629)
    end
  end
end


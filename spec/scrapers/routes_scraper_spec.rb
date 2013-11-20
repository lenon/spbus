require "spec_helper"

describe SpBus::Scrapers::Routes do

  describe "#fetch", vcr: { cassette_name: "bus_routes" } do

    before { subject.fetch }

    it "returns all bus routes" do
      expect(subject.routes).to have(1315).items
    end

    it "returns a Route object for every found route" do
      subject.routes.each do |route|
        expect(route).to be_kind_of(SpBus::Route)
      end
    end

    it "sets route number" do
      expect(subject.routes.first.number).to eql("1016-10")
      expect(subject.routes.last.number).to eql("978T-10")
    end

    it "sets route one_way attribute" do
      expect(subject.routes.first.one_way?).to be_false
      expect(subject.routes[10].one_way?).to be_true
    end
  end
end


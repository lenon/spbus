require "spec_helper"

describe SpBus do

  subject { described_class }

  describe ".fetch_routes" do

    let(:route1) { SpBus::Route.new("6400-10") }
    let(:route2) { SpBus::Route.new("6450-10") }
    let(:scraper) { double.as_null_object }

    before do
      allow_any_instance_of(SpBus::Scrapers::Routes).to receive(:fetch)
      allow_any_instance_of(SpBus::Scrapers::Routes).to receive(:routes)
        .and_return([route1, route2])
    end

    it "fetch route details for every route" do
      expect(SpBus::Scrapers::RouteDetails).to receive(:new).with(route1)
        .and_return(scraper)

      expect(SpBus::Scrapers::RouteDetails).to receive(:new).with(route2)
        .and_return(scraper)

      expect(scraper).to receive(:fetch).twice

      expect(subject.fetch_routes).to eql([route1, route2])
    end

    it "does not return an invalid route" do
      allow(SpBus::Scrapers::RouteDetails).to receive(:new)
        .with(anything).and_return(scraper)

      expect(scraper).to receive(:fetch).ordered.and_raise(SpBus::InvalidRoute)
      expect(scraper).to receive(:fetch).ordered

      expect(subject.fetch_routes).to eql([route2])
    end

    it "yields a block" do
      allow_any_instance_of(SpBus::Scrapers::RouteDetails).to receive(:fetch)

      expect { |b| subject.fetch_routes(&b) }.to yield_successive_args(route1, route2)
    end
  end

  describe ".fetch_buses" do

    let(:scraper) { double.as_null_object }
    let(:buses)   { double }

    it "fetch all buses locations for a given destination" do
      expect(SpBus::Scrapers::Locations).to receive(:new).with(1234).and_return(scraper)
      expect(scraper).to receive(:fetch)
      allow(scraper).to receive(:buses).and_return(buses)

      expect(subject.fetch_buses(1234)).to eql(buses)
    end
  end
end


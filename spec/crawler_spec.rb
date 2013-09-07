require "spec_helper"

describe SpBus::Crawler do

  describe "#fetch_routes", :vcr do

    before { subject.fetch_routes }

    it "returns all bus routes" do
      expect(subject.routes.size).to eql(1320)
    end

    it "returns creates a Route object for every found route" do
      subject.routes.each do |l|
        expect(l).to be_kind_of(SpBus::Route)
      end
    end
  end
end


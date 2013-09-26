require "spec_helper"

describe SpBus::Scrapers::RouteDetails do

  describe "#fetch" do

    subject { described_class.new(route) }

    context "invalid route", vcr: { cassette_name: "invalid_route_detail" } do

      let(:route) { SpBus::Route.new("banana") }

      it "raises an error" do
        expect {
          subject.fetch
        }.to raise_error
      end
    end

    context "normal route", vcr: { cassette_name: "normal_route_detail" } do

      let(:route) { SpBus::Route.new("6450-10") }
      before { subject.fetch }

      it "sets origin" do
        expect(route.origin).to eql("TERM. CAPELINHA")
      end

      it "sets destination" do
        expect(route.destination).to eql("TERM. BANDEIRA")
      end

      it "sets destination id" do
        expect(route.destination_id).to eql(59)
      end

      it "sets origin id" do
        expect(route.origin_id).to eql(32827)
      end
    end

    context "one way route", vcr: { cassette_name: "one_way_route_detail" } do

      let(:route) { SpBus::Route.new("1177-42") }
      before do
        route.one_way = true
        subject.fetch
      end

      it "sets origin" do
        expect(route.origin).to eql("ENGENHEIRO GOULART")
      end

      it "sets destination" do
        expect(route.destination).to eql("TERM. PQ.D. PEDRO II")
      end

      it "sets destination id" do
        expect(route.destination_id).to eql(130)
      end

      it "does not set origin id" do
        expect(route.origin_id).to be_nil
      end
    end
  end
end


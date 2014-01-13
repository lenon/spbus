require "spec_helper"

describe SpBus::Client do

  subject { described_class.new(sptrans_token) }

  describe "#authenticate" do

    context "valid credentials" do
      it "returns true" do
        use_cassette(:successful_authentication) do
          expect(subject.authenticate).to be true
        end
      end
    end

    context "invalid credentials" do
      subject { described_class.new(sptrans_invalid_token) }

      it "raises an error" do
        use_cassette(:unsuccessful_authentication) do
          expect {
            subject.authenticate
          }.to raise_error(SpBus::AuthenticationError)
        end
      end
    end
  end

  describe "#search" do

    context "unauthenticated" do
      it "raises an error" do
        use_cassette(:unauthenticated_search) do
          expect {
            subject.search("BANANA")
          }.to raise_error(SpBus::HTTPError)
        end
      end
    end

    context "authenticated" do
      before do
        use_cassette(:successful_authentication) do
          subject.authenticate
        end
      end

      context "empty results" do
        it "returns an empty array" do
          use_cassette(:empty_search_results) do
            expect(subject.search(sptrans_unknown_search)).to be_empty
          end
        end
      end

      context "found results" do
        it "returns an array of lines" do
          use_cassette(:search_results) do
            expect(subject.search(sptrans_known_search)).to have(2).items
          end
        end
      end
    end
  end

  describe "#stops" do

    context "unauthenticated" do
      it "raises an error" do
        use_cassette(:unauthenticated_stops) do
          expect {
            subject.stops(123)
          }.to raise_error(SpBus::HTTPError)
        end
      end
    end

    context "authenticated" do
      before do
        use_cassette(:successful_authentication) do
          subject.authenticate
        end
      end

      context "empty results" do
        it "returns an empty array" do
          use_cassette(:empty_line_stops_results) do
            expect(subject.stops(sptrans_unknown_line)).to be_empty
          end
        end
      end

      context "found results" do
        it "returns an array of Stops" do
          use_cassette(:line_stops_results) do
            expect(subject.stops(sptrans_known_line)).to have(15).items
          end
        end
      end
    end
  end

  describe "#buses" do

    context "unauthenticated" do
      it "raises an error" do
        use_cassette(:unauthenticated_buses) do
          expect {
            subject.buses(123)
          }.to raise_error(SpBus::HTTPError)
        end
      end
    end

    context "authenticated" do
      before do
        use_cassette(:successful_authentication) do
          subject.authenticate
        end
      end

      context "empty results" do
        it "returns an empty array" do
          use_cassette(:empty_line_buses_results) do
            expect(subject.buses(sptrans_unknown_line)).to be_empty
          end
        end
      end

      context "found results" do
        it "returns an array of Buses" do
          use_cassette(:line_buses_results) do
            expect(subject.buses(sptrans_known_line)).to have(3).item
          end
        end
      end
    end
  end
end

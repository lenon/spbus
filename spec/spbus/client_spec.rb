require "spec_helper"

describe SpBus::Client do

  let(:token) { SpecEnv.valid_api_token }
  subject { described_class.new(token) }

  describe "#authenticate" do

    context "when API token is valid" do
      it "returns true" do
        use_cassette(:successful_authentication) do
          expect(subject.authenticate).to be true
        end
      end
    end

    context "when API token is not valid" do

      let(:token) { SpecEnv.invalid_api_token }

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

    let(:query) { SpecEnv.known_search }
    let(:results) { subject.search(query) }

    context "unauthenticated connection" do
      it "raises an error" do
        use_cassette(:unauthenticated_search) do
          expect { results }.to raise_error(SpBus::HTTPError)
        end
      end
    end

    context "authenticated connection" do
      before do
        use_cassette(:successful_authentication) do
          subject.authenticate
        end
      end

      context "with no results" do

        let(:query) { SpecEnv.unknown_search }

        it "returns an empty array" do
          use_cassette(:empty_search_results) do
            expect(results).to be_empty
          end
        end
      end

      context "with some results" do
        it "returns an array of Lines" do
          use_cassette(:search_results) do
            expect(results).to have(2).items
            expect(results.first).to be_kind_of(SpBus::Line)
          end
        end
      end
    end
  end

  describe "#stops" do

    let(:line) { SpecEnv.known_line }
    let(:results) { subject.stops(line) }

    context "unauthenticated connection" do
      it "raises an error" do
        use_cassette(:unauthenticated_stops) do
          expect { results }.to raise_error(SpBus::HTTPError)
        end
      end
    end

    context "authenticated connection" do
      before do
        use_cassette(:successful_authentication) do
          subject.authenticate
        end
      end

      context "with no results" do

        let(:line) { SpecEnv.unknown_line }

        it "returns an empty array" do
          use_cassette(:empty_line_stops_results) do
            expect(results).to be_empty
          end
        end
      end

      context "with some results" do
        it "returns an array of Stops" do
          use_cassette(:line_stops_results) do
            expect(results).to have(15).items
            expect(results.first).to be_kind_of(SpBus::Stop)
          end
        end
      end
    end
  end

  describe "#buses" do

    let(:line) { SpecEnv.known_line }
    let(:results) { subject.buses(line) }

    context "unauthenticated connection" do
      it "raises an error" do
        use_cassette(:unauthenticated_buses) do
          expect { results }.to raise_error(SpBus::HTTPError)
        end
      end
    end

    context "authenticated connection" do
      before do
        use_cassette(:successful_authentication) do
          subject.authenticate
        end
      end

      context "with no results" do

        let(:line) { SpecEnv.unknown_line }

        it "returns an empty array" do
          use_cassette(:empty_line_buses_results) do
            expect(results).to be_empty
          end
        end
      end

      context "with some results" do
        it "returns an array of Buses" do
          use_cassette(:line_buses_results) do
            expect(results).to have(3).item
            expect(results.first).to be_kind_of(SpBus::Bus)
          end
        end
      end
    end
  end
end

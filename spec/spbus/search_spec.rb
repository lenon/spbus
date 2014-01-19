require "spec_helper"

describe SpBus::Search do

  let(:query) { SpecEnv.known_search }
  let(:connection) { authorized_connection }

  subject { described_class.new(connection, query) }

  describe "#results" do

    context "with no results" do

      let(:query) { SpecEnv.unknown_search }

      it "returns an empty array" do
        use_cassette(:empty_search_results) do
          expect(subject.results).to be_empty
        end
      end
    end

    context "with some results" do
      it "returns an array of Lines" do
        use_cassette(:search_results) do
          results = subject.results
          expect(results).to have(2).items
          expect(results.first).to be_kind_of(SpBus::Line)
        end
      end
    end
  end
end

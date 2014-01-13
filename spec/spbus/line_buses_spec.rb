require "spec_helper"

describe SpBus::LineBuses do

  let(:connection) { authorized_connection }
  subject { described_class.new(connection, sptrans_known_line) }

  describe "#results" do

    context "empty results" do
      subject { described_class.new(connection, sptrans_unknown_line) }

      it "returns an empty array" do
        use_cassette(:empty_line_buses_results) do
          expect(subject.results).to be_empty
        end
      end
    end

    context "found results" do
      it "returns an array of Buses" do
        use_cassette(:line_buses_results) do
          results = subject.results
          expect(results).to have(3).items
          expect(results.first).to be_kind_of(SpBus::Bus)
        end
      end
    end
  end
end

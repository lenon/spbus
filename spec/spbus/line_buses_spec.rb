require "spec_helper"

describe SpBus::LineBuses do

  let(:line) { SpecEnv.known_line }
  let(:connection) { authorized_connection }

  subject { described_class.new(connection, line) }

  describe "#results" do

    context "with no results" do

      let(:line) { SpecEnv.unknown_line }

      it "returns an empty array" do
        use_cassette(:empty_line_buses_results) do
          expect(subject.results).to be_empty
        end
      end
    end

    context "with some results" do
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

require "spec_helper"

describe SpBus::Route do

  subject { described_class.new("5704-10") }

  it { should respond_to(:number) }
  it { should respond_to(:origin) }
  it { should respond_to(:destination) }
  it { should respond_to(:code_for_origin) }
  it { should respond_to(:code_for_destination) }

  describe "#fetch_details", :vcr do

    subject { described_class.new("6450-10") }
    before { subject.fetch_details }

    it "sets route position codes" do
      expect(subject.code_for_origin).to eql(59)
      expect(subject.code_for_destination).to eql(32827)
    end

    it "sets origin attribute" do
      expect(subject.origin).to eql("TERM. CAPELINHA")
    end

    it "sets destination attribute" do
      expect(subject.destination).to eql("TERM. BANDEIRA")
    end
  end

  describe "#to_h", :vcr do

    subject { described_class.new("6450-10") }
    before { subject.fetch_details }

    it "returns a hash" do
      expect(subject.to_h).to eql({
        number: "6450-10",
        origin: "TERM. CAPELINHA",
        destination: "TERM. BANDEIRA",
        code_for_origin: 59,
        code_for_destination: 32827
      })
    end
  end
end


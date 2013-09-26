require "spec_helper"

describe SpBus::Route do

  subject { described_class.new("6450-10") }

  it { should respond_to(:number) }
  it { should respond_to(:origin) }
  it { should respond_to(:destination) }
  it { should respond_to(:origin_id) }
  it { should respond_to(:destination_id) }

  it { should respond_to(:number=) }
  it { should respond_to(:origin=) }
  it { should respond_to(:destination=) }
  it { should respond_to(:one_way=) }
  it { should respond_to(:origin_id=) }
  it { should respond_to(:destination_id=) }

  describe "initializer" do
    it "receives route number" do
      route = described_class.new("6450-10")
      expect(route.number).to eql("6450-10")
    end
  end

  describe "#one_way?" do
    it "returns true when one_way attr is true" do
      subject.one_way = true
      expect(subject.one_way?).to be_true
    end

    it "returns false when one_way attr is false" do
      subject.one_way = false
      expect(subject.one_way?).to be_false
    end
  end
end


require "spec_helper"

describe SpBus::Bus do
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:route) }

  it { should respond_to(:latitude=) }
  it { should respond_to(:longitude=) }
  it { should respond_to(:route=) }
end


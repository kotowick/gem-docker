require "spec_helper"

describe Docker do
  it "has a version number" do
    expect(Docker::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end

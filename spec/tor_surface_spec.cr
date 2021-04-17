require "../src/tor_surface"
require "spec"

describe TorSurface do
  describe "#[]" do
    it "sets specific items" do
      surface = TorSurface.new(10, 10)
      surface[1, 1] = true
      surface[1, 1].should be_truthy
    end

    it "emulates tor with x coordinate" do
      surface = TorSurface.new(10, 10)
      surface[11, 1] = true
      surface[1, 1].should be_truthy
    end

    it "emulates tor with y coordinate" do
      surface = TorSurface.new(10, 10)
      surface[1, 11] = true
      surface[1, 1].should be_truthy
    end
  end
end

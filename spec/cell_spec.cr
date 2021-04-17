require "../src/cell"
require "../src/tor_surface"
require "spec"

describe Cell do
  describe "#neighbours_count" do
    it "calculates neighbours in the surface middle" do
      surface = TorSurface.new(10, 10)
      surface[4, 5] = true
      surface[6, 5] = true
      surface[5, 4] = true
      surface[5, 6] = true
      surface[4, 4] = true
      surface[6, 6] = true
      x = 5
      y = 5
      cell = Cell.new(x, y, surface)
      cell.calculate_next_state
      cell.neighbours_count.should eq 6
    end

    it "calculates neighbours in the surface beginning" do
      surface = TorSurface.new(10, 10)
      surface[11, 0] = true
      surface[0, 11] = true
      x = 0
      y = 0
      cell = Cell.new(x, y, surface)
      cell.calculate_next_state
      cell.neighbours_count.should eq 2
    end
  end

  describe "#next_state" do
    it "will be alive if it was dead and has 3 alive neighbours (birth)" do
      surface = TorSurface.new(10, 10)
      surface[4, 5] = true
      surface[6, 5] = true
      surface[5, 4] = true
      x = 5
      y = 5
      cell = Cell.new(x, y, surface)
      cell.calculate_next_state
      cell.will_live?.should be_truthy
    end

    it "will be alive if it was alive and has 2 alive neighbours" do
      surface = TorSurface.new(10, 10)
      surface[4, 5] = true
      surface[6, 5] = true
      surface[5, 5] = true
      x = 5
      y = 5
      cell = Cell.new(x, y, surface)
      cell.calculate_next_state
      cell.will_live?.should be_truthy
    end

    it "will be alive if it was alive and has 3 alive neighbours" do
      surface = TorSurface.new(10, 10)
      surface[4, 5] = true
      surface[6, 5] = true
      surface[5, 4] = true
      surface[5, 5] = true
      x = 5
      y = 5
      cell = Cell.new(x, y, surface)
      cell.calculate_next_state
      cell.will_live?.should be_truthy
    end

    it "will be dead if it was alive and faiced loneliness (< 2 neighbours)" do
      surface = TorSurface.new(10, 10)
      surface[4, 5] = true
      surface[5, 5] = true
      x = 5
      y = 5
      cell = Cell.new(x, y, surface)
      cell.calculate_next_state
      cell.will_die?.should be_truthy
    end

    it "will be dead if it was alive and faiced loneliness (> 3 overpopulation)" do
      surface = TorSurface.new(10, 10)
      surface[6, 5] = true
      surface[5, 4] = true
      surface[5, 6] = true
      surface[4, 4] = true
      surface[5, 5] = true
      x = 5
      y = 5
      cell = Cell.new(x, y, surface)
      cell.calculate_next_state
      cell.will_die?.should be_truthy
    end
  end

  describe "#apply_next_state" do
    it "applies next state" do
      surface = TorSurface.new(10, 10)
      x = 5
      y = 5
      cell = Cell.new(x, y, surface)
      cell.next_state = true
      cell.apply_next_state
      surface[x, y].should be_truthy
    end
  end
end

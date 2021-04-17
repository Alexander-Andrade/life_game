require "bit_array"
require "./surfacable"

class TorSurface
  include Surfacable

  getter :width, :height
  private property surface

  def initialize(@width : Int32, @height : Int32)
    @surface = Array(BitArray).new(size: height) { BitArray.new(width) }
  end

  def [](x, y)
    surface[y_cord(y)][x_cord(x)]
  end

  def []=(x, y, val)
    surface[y_cord(y)][x_cord(x)] = val
  end

  private def x_cord(x)
    x >= width ? x % width : x
  end

  private def y_cord(y)
    y >= height ? y % height : y
  end
end

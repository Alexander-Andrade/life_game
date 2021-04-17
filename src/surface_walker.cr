require "./surfacable"


class SurfaceWalker
  getter :surface

  def initialize(@surface : Surfacable)
  end

  def walk(*, start_x = nil, start_y = nil, end_x = nil, end_y = nil)
    x_start = start_x.nil? ? 0 : start_x
    y_start = start_y.nil? ? 0 : start_y
    y_end = end_y.nil? ? surface.height - 1 : end_y
    x_end = end_x.nil? ? surface.width - 1 : end_x

    i = 0
    y_start.upto(y_end) do |y|
      x_start.upto(x_end) do |x|
        yield(x, y, i)
        i += 1
      end
    end
  end
end
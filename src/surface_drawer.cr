require "./surfacable"
require "./surface_walker"

class SurfaceDrawer
  getter :surface
  getter surface_walker : SurfaceWalker

  def initialize(@surface : Surfacable, surface_walker_class = SurfaceWalker)
    @surface_walker = surface_walker_class.new(surface)
  end

  def draw
    clear_console

    surface_walker.walk do |x, y, i|
      print_cell(x, y)
      print_newline(i)
    end
  end

  private def print_cell(x, y)
    print(surface[x, y] == true ?  "@ " : "  ")
  end

  private def print_newline(i)
    print('\n') if ((i + 1) % surface.width).zero?
  end

  private def clear_console
    print "\33c\e[3J"
  end
end

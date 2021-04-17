require "./surfacable"
require "./surface_walker"
require "./cell"

class SurfaceCellsGenerator
  property :surface
  getter surface_walker : SurfaceWalker

  def initialize(@surface : Surfacable, surface_walker_class = SurfaceWalker)
    @surface_walker = surface_walker_class.new(surface)
  end

  def generate_cells
    random = Random.new

    cells = Array(Cell).new(surface.width * surface.height) 

    surface_walker.walk do |x, y, i|
      cell = Cell.new(x, y, surface)
      surface[x, y] = true if random.next_bool
      cells << cell
    end

    cells
  end
end

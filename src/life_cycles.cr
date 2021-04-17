require "./surfacable"
require "./surface_drawer"
require "./surface_cells_generator"
require "./surface_walker"


class LifeCycles
  getter :drawer
  getter cells : Array(Cell)
  property :surface

  def initialize(@surface : Surfacable)
    @drawer = SurfaceDrawer.new(surface)
    @cells = SurfaceCellsGenerator.new(surface).generate_cells
  end

  def run
    drawer.draw
    cycle = 0    
    while true 
      cells.each(&.calculate_next_state)
      cells.each(&.apply_next_state)
      drawer.draw
      print(cycle)

      sleep(1)
      cycle += 1
    end
  end
end

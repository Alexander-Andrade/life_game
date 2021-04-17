require "./surfacable"
# error raises only if to run file directly 
require "./surface_walker"

class Cell
  getter :x, :y
  property :surface
  property :neighbours_count
  property :next_state
  getter surface_walker : SurfaceWalker 


  def initialize(@x : Int32, @y : Int32, @surface : Surfacable,
                 surface_walker_class = SurfaceWalker)
    @neighbours_count = 0
    @surface_walker = surface_walker_class.new(surface)
    @next_state = false
  end

  def calculate_next_state
    @neighbours_count = count_neighbours

    if alive? && loneliness?
      will_die!
    elsif alive? && overpopulation?
      will_die!
    elsif alive? && optimal_neighbors_count?
      will_live!
    elsif dead? && reproduction?
      will_live!
    end
  end

  def apply_next_state
    surface[x, y] = next_state
  end

  private def count_neighbours
    count = 0
    walk_borders = {
      start_x: x - 1, start_y: y - 1,
      end_x: x + 1, end_y: y + 1 
    }

    surface_walker.walk(**walk_borders) do |x_cur, y_cur|
      next if y_cur == y && x_cur == x # skip cell self coordinates
      count += 1 if surface[x_cur, y_cur] == true
    end

    count
  end

  def alive?
    surface[x, y] == true
  end

  def dead?
    surface[x, y] == false
  end

  def will_live!
    @next_state = true
  end

  def will_die!
    @next_state = false
  end

  def will_live?
    next_state == true
  end

  def will_die?
    next_state == false
  end

  private def loneliness?
    neighbours_count < 2
  end

  private def overpopulation?
    neighbours_count > 3
  end

  private def reproduction?
    neighbours_count == 3
  end

  private def optimal_neighbors_count?
    neighbours_count == 2 || neighbours_count == 3
  end
end

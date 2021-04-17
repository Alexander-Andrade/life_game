require "./src/tor_surface"
require "./src/life_cycles"

surface = TorSurface.new(30,30)

surface[3, 3] = true
surface[3, 4] = true
surface[3, 5] = true

life = LifeCycles.new(surface)
life.run

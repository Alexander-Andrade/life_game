require "./src/tor_surface"
require "./src/life_cycles"

surface = TorSurface.new(30,30)
life = LifeCycles.new(surface)
life.run

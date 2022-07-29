### PolygonTriangulation [![Run tests Main](https://github.com/Jerboa-app/PolygonTriangulation.jl/actions/workflows/main_workflow.yml/badge.svg)](https://github.com/Jerboa-app/PolygonTriangulation.jl/actions/workflows/main_workflow.yml)

#### Triangulate polygons in Julia using the O(n^2), for n = vertex count, algorithm of ElGindy et al, [Slicing an Ear Using Prune and Search](https://www.sciencedirect.com/science/article/abs/pii/016786559390141Y)

The code is built purposely to rely only on base Julia, rather than use the Julia geometry ecosystem, to give an example of a fully standalone implementation of the algorithm. Julia's geometry ecosystem provides a few more efficient algorithms!

For a generally better approach to the whole problem (e.g with wholes and intersections), checkout [earcut](https://github.com/mapbox/earcut) (in various languages), which includes all kinds of additional algorithm robustness and optimisation improvements!

![examples](https://raw.githubusercontent.com/Jerboa-app/PolygonTriangulation.jl/adds_giffing/examples/steps.gif)

Some bugs persist on large polygons (~N=32), where triangles form outside the perimiter, these are reasonably rare. So, you probably want to use [Triangle.jl](https://github.com/cvdlab/Triangle.jl), [Triangulate.jl](https://github.com/JuliaGeometry/Triangulate.jl), [Meshes.jl](https://github.com/JuliaGeometry/Meshes.jl), [Meshing.jl](https://github.com/JuliaGeometry/Meshing.jl), or [VoronoiDelaunay.jl](https://github.com/JuliaGeometry/VoronoiDelaunay.jl)

However Triangulate.jl and Triangle.jl rely on the [Triangle library](http://www.cs.cmu.edu/~quake/triangle.html) which can't be used commerically without a license direct from the author.

Meshes.jl is quite general and active.

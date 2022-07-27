### PolygonTriangulation


Triangulate polygons in Julia using the O(n^2), for n = vertex count, algorithm of ElGindy et al, [Slicing an Ear Using Prune and Search](https://www.sciencedirect.com/science/article/abs/pii/016786559390141Y)

You probably want to use [Triangle.jl](https://github.com/cvdlab/Triangle.jl), [Triangulate.jl](https://github.com/JuliaGeometry/Triangulate.jl), [Meshes.jl](https://github.com/JuliaGeometry/Meshes.jl), [Meshing.jl](https://github.com/JuliaGeometry/Meshing.jl), or [VoronoiDelaunay.jl](https://github.com/JuliaGeometry/VoronoiDelaunay.jl)

However Triangulate.jl and Triangle.jl rely on the [Triangle library](http://www.cs.cmu.edu/~quake/triangle.html) which can't be used commerically without a license direct from the author.

Meshes.jl is quite general and active.

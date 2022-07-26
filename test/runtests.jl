using Test
my_tests = [
  "test_vertex.jl",
  "test_polygon.jl",
  "test_findear.jl",
  "test_triangulate.jl"
]

println("Running tests:")
for my_test in my_tests
  include(my_test)
end

using PolygonTriangulation
using Test

@testset "Vertex arithmetic" begin
    @test Vertex(10.,0.) + Vertex(-10.,1.) == Vertex(0.,1.)
    @test Vertex(1.,2.)⋅Vertex(2.,3.) == 8.
    @test Vertex(1.,1.)-Vertex(1.,1.) == Vertex(0.,0.)
    @test 4.5*Vertex(1.,2.) == Vertex(4.5,9.)
    @test 4.8*Vertex(3.,5.) == Vertex(3.,5.)*4.8
    @test norm(Vertex(1.,3.)) == sqrt(1.0*1.0+3.0*3.)
    @test Vertex(1.,2.)/3. == Vertex(1.0/3.,2.0/3.)
    @test ×(Vertex(1.,-2.),Vertex(-2.,2.)) == 1.0*2.0-(-2.0*-2.0)
end

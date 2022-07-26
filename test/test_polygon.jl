using PolygonTriangulation
using Test

@testset "Polygon Handed-ness" begin

    P = Polygon([Vertex(0.0,0.0),Vertex(1.0,0.0),Vertex(0.0,1.0)])

    @test length(P) == 3

    @test handedNess(P) == Left

    P = Polygon([Vertex(0.0,0.0),Vertex(0.0,1.0),Vertex(1.0,0.0)])
    @test handedNess(P) == Right
    @test PolygonTriangulation.angleSign(P,Int(1)) == Right
    @test PolygonTriangulation.angleSign(P,Int(2)) == Right
    @test PolygonTriangulation.angleSign(P,Int(3)) == Right

    P = Polygon(
        [
            Vertex(0.0,0.0),
            Vertex(0.0,1.0),
            Vertex(1.0,0.0),
            Vertex(0.5,0.5)
        ]
    );

    @test handedNess(P) == Right

    @test PolygonTriangulation.angleSign(P,Int(4)) == Left

end

@testset "Polygon indexing" begin

    P = Polygon([Vertex(0.0,0.0),Vertex(1.0,0.0),Vertex(0.0,1.0)])
    n = length(P)
    @test PolygonTriangulation.previousIndex(1,n) == 3
    @test PolygonTriangulation.nextIndex(1,n) == 2
    @test PolygonTriangulation.nextIndex(3,n) == 1
end

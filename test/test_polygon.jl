using PolygonTriangulation
using Test

@testset "Polygon Handed-ness" begin

    P = Polygon([Vertex(0.0,0.0),Vertex(1.0,0.0),Vertex(0.0,1.0)])
    @test handedNess(P) == Left

    P = Polygon([Vertex(0.0,0.0),Vertex(0.0,1.0),Vertex(1.0,0.0)])
    @test handedNess(P) == Right
    @test PolygonTriangulation.angleSign(P,UInt64(1)) == Right
    @test PolygonTriangulation.angleSign(P,UInt64(2)) == Right
    @test PolygonTriangulation.angleSign(P,UInt64(3)) == Right

    P = Polygon(
        [
            Vertex(0.0,0.0),
            Vertex(0.0,1.0),
            Vertex(1.0,0.0),
            Vertex(0.5,0.5)
        ]
    );

    @test handedNess(P) == Right

    @test PolygonTriangulation.angleSign(P,UInt64(4)) == Left

end

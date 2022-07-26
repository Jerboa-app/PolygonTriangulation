using PolygonTriangulation
using Test

@testset "Triangulation" begin

    P = Polygon(
        [
            Vertex(0.0,0.0),
            Vertex(0.0,1.0),
            Vertex(1.0,0.0),
            Vertex(0.5,0.5)
        ]
    );

    @test triangulate(P) == [[P.vertices[4],P.vertices[1],P.vertices[2]],[P.vertices[2],P.vertices[3],P.vertices[4]]]

end

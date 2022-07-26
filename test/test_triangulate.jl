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

    P = Polygon(
        [
            Vertex(0.0,0.0),
            Vertex(0.33,1.25),
            Vertex(0.575,0.75),
            Vertex(1.,1.)
        ]
    )

    @test triangulate(P) == [
                        [Vertex(0.0, 0.0), Vertex(0.33, 1.25), Vertex(0.575, 0.75)],
                        [Vertex(0.0, 0.0), Vertex(0.575, 0.75), Vertex(1.0, 1.0)]
                      ]
end

@testset "Given a Left handed Polygon" begin

        v = [Vertex(1.0018487477025975, 0.0)
     Vertex(1.0410841583029593, 0.7563919162397653)
     Vertex(-0.32112791516681294, -0.9883300978363111)
     Vertex(1.206290630536759, -0.8764214442193581)]

    P = Polygon(v)

    @test triangulate(P) == [
        [Vertex(1.0018487477025975, 0.0), Vertex(1.206290630536759, -0.8764214442193581), Vertex(-0.32112791516681294, -0.9883300978363111)],
        [Vertex(-0.32112791516681294, -0.9883300978363111), Vertex(1.0410841583029593, 0.7563919162397653), Vertex(1.0018487477025975, 0.0)]
        ]

end

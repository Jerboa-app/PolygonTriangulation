@recipe(PolygonPlot) do scene
    Attributes(
        vertexColour = RGBAf0(194/255,200/255,1.,1.),
        edgeColour = RGBAf0(0.,0.,1.,1.),
        trianglulationColour = RGBAf0(1.,0.,0.,1.),
    )
end

function Makie.plot!(
    p::PolygonPlot{<:Tuple{<:Polygon}},
    )

    poly = p[1]

    edges = Observable(Point2f0[])
    vertices = Observable(Point2f0[])

    function update_plot(p::Polygon)
        empty!(edges[])
        empty!(vertices[])


        u = p.vertices[1]
        push!(vertices[],Point2f0(u.x,u.y))
        for (i,v) in enumerate(p.vertices[2:end])
            push!(vertices[],Point2f0(v.x,v.y))
            if (i < length(p))
                push!(edges[],Point2f0(u.x,u.y))
                push!(edges[],Point2f0(v.x,v.y))
            end
            u = v
        end
        push!(edges[],Point2f0(p.vertices[end].x,p.vertices[end].y))
        push!(edges[],Point2f0(p.vertices[1].x,p.vertices[1].y))
    end

    Makie.Observables.onany(update_plot,poly)
    update_plot(poly[])

    linesegments!(p,edges,color=p.edgeColour)
    scatter!(p,vertices,color=p.vertexColour)
    p
end

function Makie.plot!(
    p::PolygonPlot{<:Tuple{<:Polygon,<:AbstractVector{<:AbstractVector{Vertex}}}},
    )

    poly = p[1]
    triangles = p[2]

    edges = Observable(Point2f0[])
    vertices = Observable(Point2f0[])
    triangleEdges = Observable(Point2f0[])

    function update_plot(p::Polygon,triangle::Vector{Vector{Vertex}})
        empty!(edges[])
        empty!(vertices[])
        empty!(triangleEdges[])


        u = p.vertices[1]
        push!(vertices[],Point2f0(u.x,u.y))
        for (i,v) in enumerate(p.vertices[2:end])
            push!(vertices[],Point2f0(v.x,v.y))
            if (i < length(p))
                push!(edges[],Point2f0(u.x,u.y))
                push!(edges[],Point2f0(v.x,v.y))
            end
            u = v
        end
        push!(edges[],Point2f0(p.vertices[end].x,p.vertices[end].y))
        push!(edges[],Point2f0(p.vertices[1].x,p.vertices[1].y))

        for tri in triangles[]
            push!(triangleEdges[],Point2f0(tri[1].x,tri[1].y))
            push!(triangleEdges[],Point2f0(tri[2].x,tri[2].y))
            push!(triangleEdges[],Point2f0(tri[2].x,tri[2].y))
            push!(triangleEdges[],Point2f0(tri[3].x,tri[3].y))
            push!(triangleEdges[],Point2f0(tri[3].x,tri[3].y))
            push!(triangleEdges[],Point2f0(tri[1].x,tri[1].y))
        end

    end

    Makie.Observables.onany(update_plot,poly,triangles)
    update_plot(poly[],triangles[])

    linesegments!(p,edges,color=p.edgeColour)
    scatter!(p,vertices,color=p.vertexColour)
    linesegments!(p,triangleEdges,color=p.trianglulationColour,linestyle=:dash)
    p
end

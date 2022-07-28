function eventFrames(p::Polygon,events::Vector{PolygonTriangulation.Event})
    fig = Figure()
    ax = Axis(fig[1,1])

    record(fig,"steps.gif",framerate=1,0:length(events)-1) do i

        if (i == 0)
            baseFrame!(ax,P)
        else
            eventFrame!(ax,p,events[i])
        end
    end

end

function baseFrame!(ax::Axis,P::Polygon)
    scatter!(ax,[Point2f0(v.x,v.y) for v in P.vertices])
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(P)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end
    linesegments!(ax,e)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.TestingVertexEvent)
    scatter!(ax,[Point2f0(evt.v.x,evt.v.y)],marker=:rect,color=:red)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.BisectorEvent)
    lines!(ax,[Point2f0(evt.o.x,evt.o.y),Point2f0(evt.ray.x,evt.ray.y)],color=:red,linestyle=:dash)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.IntersectionEvent)
   scatter!(ax,[Point2f0(evt.v.x,evt.v.y)],marker=:cross,color=:black)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.TestingTriangleEvent)
    linesegments!(ax,[
        Point2f0(evt.a.x,evt.a.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.a.x,evt.a.y)
        ],color=:green,linestyle=:dot,linewidth=4)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.FoundDiagonalEvent)
    lines!(ax,[Point2f0(evt.a.x,evt.a.y),Point2f0(evt.b.x,evt.b.y)],color=:black)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.GoodSubPolygonEvent)
    empty!(ax)

    scatter!(ax,[Point2f0(v.x,v.y) for v in p.vertices],color=RGBAf0(0.,0.,1.,0.33))
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(p)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end

    q = evt.p

    linesegments!(ax,e,color=RGBAf0(0.,0.,1.,0.33))
    scatter!(ax,[Point2f0(v.x,v.y) for v in q.vertices],color=RGBAf0(0.,0.,1.,1.0))
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(q)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end
    linesegments!(ax,e,color=RGBAf0(0.,0.,1.,1.0))

end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.FoundEarEvent)
    empty!(ax)
    scatter!(ax,[Point2f0(v.x,v.y) for v in p.vertices],color=RGBAf0(0.,0.,1.,1.0))
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(p)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end
    scatter!(ax,[Point2f0(evt.ear.x,evt.ear.y)],color=:white,marker=:cross)
    linesegments!(ax,e,color=RGBAf0(0.,0.,1.,1.0))
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.FoundTriangleEvent)
    linesegments!(ax,[
        Point2f0(evt.a.x,evt.a.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.a.x,evt.a.y)
        ],color=:red,linestyle=:dash,linewidth=4)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.FoundEarEvent)
    empty!(ax)
    scatter!(ax,[Point2f0(v.x,v.y) for v in p.vertices],color=RGBAf0(0.,0.,1.,1.0))
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(p)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end
    scatter!(ax,[Point2f0(evt.ear.x,evt.ear.y)],color=:white,marker=:cross)
    linesegments!(ax,e,color=RGBAf0(0.,0.,1.,1.0))
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.FoundTriangleEvent)
    linesegments!(ax,[
        Point2f0(evt.a.x,evt.a.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.a.x,evt.a.y)
        ],color=:red,linestyle=:dash,linewidth=4)
end

function eventFrames(p::Polygon,events::Vector{PolygonTriangulation.Event})
    fig = Figure()
    ax = Axis(fig[1,1])

    q = Polygon(P.vertices)
    gsp = nothing
    triangles = []
    alpha = 1.0

    record(fig,"steps.gif",framerate=1,1:length(events)-1) do i

        e = events[i]
        empty!(ax)

        if (typeof(e)==PolygonTriangulation.GoodSubPolygonEvent)
            gsp = e
        end

        baseFrame!(ax,P,alpha)

        if (alpha < 1.)
            if (gsp != nothing)
                eventFrame!(ax,q,gsp)
            else
                baseFrame!(ax,q,1.)
            end
        elseif (gsp != nothing)
            eventFrame!(ax,q,gsp)
        end


        if (typeof(e)!=PolygonTriangulation.GoodSubPolygonEvent)
            eventFrame!(ax,q,e)
        end

        if (typeof(e)==PolygonTriangulation.FoundEarEvent)
            alpha = 0.33
            v = []
            for i in 1:length(q)
                if (q.vertices[i] != e.ear)
                    push!(v,q.vertices[i])
                end
            end
            q = Polygon(v)
            gsp = nothing
        end

        if (typeof(e) == PolygonTriangulation.FoundTriangleEvent)
            push!(triangles,e)
        end

        for evtTri in triangles
            eventFrame!(ax,P,evtTri)
        end
    end
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.FoundEarEvent)
    scatter!(ax,[Point2f0(v.x,v.y) for v in p.vertices],color=RGBAf0(0.,0.,1.,1.0))
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(p)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end
    scatter!(ax,[Point2f0(evt.ear.x,evt.ear.y)],color=:white,marker=:cross)
    linesegments!(ax,e,color=RGBAf0(0.,0.,1.,1.0))
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.GoodSubPolygonEvent)
    q = evt.p
    scatter!(ax,[Point2f0(v.x,v.y) for v in q.vertices],color=RGBAf0(0.,0.,1.,1.0))
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(q)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end
    linesegments!(ax,e,color=RGBAf0(0.,1.,1.,1.0),linestyle=:dot)

end

function baseFrame!(ax::Axis,P::Polygon,alpha=1.0)
    scatter!(ax,[Point2f0(v.x,v.y) for v in P.vertices],color=RGBAf0(0.,0.,1.,alpha))
    e = Vector{Point2f0}([])
    for edge in PolygonTriangulation.edges(P)
        push!(e,Point2f0(edge[1].x,edge[1].y))
        push!(e,Point2f0(edge[2].x,edge[2].y))
    end
    linesegments!(ax,e,color=RGBAf0(0.,0.,1.,alpha))
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.TestingVertexEvent)
    scatter!(ax,[Point2f0(evt.v.x,evt.v.y)],marker=:rect,color=:red)
end

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.BisectorEvent)
    lines!(ax,[Point2f0(evt.o.x,evt.o.y),Point2f0(evt.o.x+evt.ray.x,evt.o.y+evt.ray.y)],color=:red,linestyle=:dash)
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

function eventFrame!(ax::Axis,p::Polygon,evt::PolygonTriangulation.FoundTriangleEvent)
    linesegments!(ax,[
        Point2f0(evt.a.x,evt.a.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.b.x,evt.b.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.c.x,evt.c.y),
        Point2f0(evt.a.x,evt.a.y)
        ],color=RGBAf0(0.5,0.5,0.5,1.0),linewidth=2)
end

module PolygonTriangulation

import Base:length,+,-,*,/

include("Vertex.jl")
include("utils.jl")
include("Polygon.jl")
include("Events.jl")
include("findEar.jl")

export triangulate, Vertex, Polygon, +,-,*,/,⋅,×,norm,Hand,handedNess,Left,Right

function triangulate(p::Polygon,events::MaybeEvents=nothing)::Vector{Vector{Vertex}}
    q = Polygon(p.vertices)
    if (handedNess(p) == Left)
        @warn "Given Left handed Polygon, converting to Right handed"
        q = Polygon(reverse(p.vertices))
    end
    triangles = Vector{Vector{Vertex}}([])
    while length(q)>3
        i = 1 # is random better?
        ear = findEar(q,q,i,events)
        earId = 0
        v = Vector{Vertex}([])
        for j in 1:length(q)
            if q.vertices[j] != ear
                push!(v,q.vertices[j])
            else
                earId = j
            end
        end
        if (events != nothing) push!(events,FoundEarEvent(ear)) end
        push!(triangles,[consecutiveTriple(q,earId)...])
        if (events != nothing) push!(events,FoundTriangleEvent(consecutiveTriple(q,earId)...)) end
        q = Polygon(v)
    end
    push!(triangles,[q.vertices...])
    if (events != nothing)
        push!(events,FoundTriangleEvent(q.vertices...))
        push!(events,QEDEvent())
    end
    return triangles
end

end # module

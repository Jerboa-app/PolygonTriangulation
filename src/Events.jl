abstract type Event end

struct TestingVertexEvent <: Event
    v::Vertex
end

struct IsEarEvent <: Event
    v::Vertex
end

struct GoodSubPolygonEvent <: Event
    p::Polygon
end

struct FoundDiagonalEvent <: Event
    a::Vertex
    b::Vertex
end

struct IntersectionEvent <: Event
    v::Vertex
end

struct TestingTriangleEvent <: Event
    a::Vertex
    b::Vertex
    c::Vertex
end

struct BisectorEvent <: Event
    o::Vertex
    ray::Vertex
end

struct FoundEarEvent <: Event
    ear::Vertex
end

struct FoundTriangleEvent <: Event
    a::Vertex
    b::Vertex
    c::Vertex
end

struct QEDEvent <: Event end

MaybeEvents = Union{Nothing,Vector{Event}}

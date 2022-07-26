struct Polygon
    vertices::Array{Vertex}
end

function length(p::Polygon)::UInt64
    return length(p.vertices)
end

function edges(p::Polygon)::Vector{Tuple{Vertex,Vertex}}
    e = Vector{Tuple{Vertex,Vertex}}([])
    for i in 1:length(p.vertices)-1
        push!(e,(p.vertices[i],p.vertices[i+1]))
    end
    push!(e,(p.vertices[length(p.vertices)],p.vertices[1]))
    return e
end

@enum Hand begin
    Left = 0
    Right = 1
end

function handedNess(p::Polygon)::Hand
    s = 0
    for e in edges(p)
        s += (e[2].x-e[1].x)*(e[2].y+e[1].y)
    end
    if (s > 0)
        return Right
    else
        return Left
    end
end

function consecutiveTriple(p::Polygon,i::UInt64)::Tuple{Vertex,Vertex,Vertex}
    n = length(p)
    a = p.vertices[mod((i-1)-1,n)+1]
    b = p.vertices[i]
    c = p.vertices[mod((i-1)+1,n)+1]
    return a,b,c
end

function angle(a::Vertex,b::Vertex,c::Vertex)
    u = a-b
    v = c-b

    u = u / norm(u)
    v = v / norm(v)
    return acos(u⋅v)
end

function angleSign(p::Polygon,i::UInt64)::Hand
    a,b,c = consecutiveTriple(p,i)
    return (b.x-a.x)*(c.y-b.y)-(b.y-a.y)*(c.x-b.x) > 0 ? Left : Right
end

function angleBisector(p::Polygon,i::UInt64)::Vertex
    a,b,c = consecutiveTriple(p,i)
    u = b-a
    v = c-b
    return norm(u)*v+norm(v)*u
end

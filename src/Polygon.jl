struct Polygon
    vertices::Array{Vertex}
end

function length(p::Polygon)::Int
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

previousIndex(i::Int,n::Int) = mod((i-1)-1,n)+1 # julia base 1
nextIndex(i::Int,n::Int) = mod((i-1)+1,n)+1     # julia base 1

function consecutiveTriple(p::Polygon,i::Int)::Tuple{Vertex,Vertex,Vertex}
    n = length(p)
    a = p.vertices[previousIndex(i,n)]
    b = p.vertices[i]
    c = p.vertices[nextIndex(i,n)]
    return a,b,c
end

function angle(a::Vertex,b::Vertex,c::Vertex)
    u = a-b
    v = c-b

    u = u / norm(u)
    v = v / norm(v)
    return acos(u⋅v)
end

function angleSign(p::Polygon,i::Int)::Hand
    a,b,c = consecutiveTriple(p,i)
    return (b.x-a.x)*(c.y-b.y)-(b.y-a.y)*(c.x-b.x) > 0 ? Left : Right
end

function angleBisector(p::Polygon,i::Int)::Vertex
    a,b,c = consecutiveTriple(p,i)
    u = a-b
    v = c-b
    return norm(u)*v+norm(v)*u
end

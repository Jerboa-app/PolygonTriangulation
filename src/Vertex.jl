struct Vertex{F<:AbstractFloat}
    x::F
    y::F
end

const NULL_VERTEX = Vertex(NaN,NaN)

function ×(v::Vertex,u::Vertex)
    return v.x*u.y-v.y*u.x
end

function ⋅(v::Vertex,u::Vertex)
    return v.x*u.x+v.y*u.y
end

function +(v::Vertex,u::Vertex)::Vertex
    return Vertex(v.x+u.x,v.y+u.y)
end

function -(v::Vertex,u::Vertex)::Vertex
    return Vertex(v.x-u.x,v.y-u.y)
end

function *(f::F,v::Vertex)::Vertex where F<:AbstractFloat
    return Vertex(v.x*f,v.y*f)
end

function *(v::Vertex,f::F)::Vertex where F<:AbstractFloat
    *(f,v)
end

function norm(v::Vertex)
    return sqrt(v.x*v.x+v.y*v.y)
end

function /(v::Vertex,f::F)::Vertex where F<:AbstractFloat
    return Vertex(v.x/f,v.y/f)
end

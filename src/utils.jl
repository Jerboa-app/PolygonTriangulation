# line p towards q, segment u-v
function lineLineSegmentIntersection(
        p::Vertex,
        q::Vertex,
        u::Vertex,
        v::Vertex
)::Vertex

    a = p - u
    b = v - u
    c = Vertex(-q.y,q.x)

    dot = b⋅c

    s = ×(b,a)/dot

    if (s < 0.)
        return NULL_VERTEX
    end

    t = a⋅c/dot

    if (t >= 0. && t <= 1.)
        return p+q*s
    end

    return NULL_VERTEX

end

function pointInTriangleInterior(point::Vertex,r1::Vertex,r2::Vertex,r3::Vertex)::Bool
    if (point == r1 || point == r2 || point == r3)
        return false
    else
        return pointInTriangle(point,r1,r2,r3)
    end
end

function pointInTriangle(point::Vertex,r1::Vertex,r2::Vertex,r3::Vertex)::Bool
    a = r3-r1
    b = r2-r1
    c = point-r1

    aDOTa = a⋅a
    aDOTb = a⋅b
    aDOTc = a⋅c
    bDOTb = b⋅b
    bDOTc = b⋅c

    inv = 1.0 / (aDOTa*bDOTb-aDOTb*aDOTb)
    u = (bDOTb*aDOTc-aDOTb*bDOTc)*inv

    if (u < 0)
        return false
    end

    v = (aDOTa*bDOTc-aDOTb*aDOTc)*inv

    if (v >= 0 && (u+v < 1))
        return true
    end

    return false

end

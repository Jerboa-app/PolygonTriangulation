# line p towards q, segment u-v
function lineLineSegmentIntersection(
        p::Vertex,
        q::Vertex,
        u::Vertex,
        v::Vertex
)::Vertex

    a = q-p
    b = v-p
    c = u-p

    if (×(a,b)*×(a,c) <= 0)
        # intersects
        r = q-p
        r = r / norm(r)
        vn = v / norm(v)
        return r*norm(v-p)/(vn⋅r)
    else
        # no intersection
        return NULL_VERTEX
    end
end

function pointInTriangle(point::Vertex,r1::Vertex,r2::Vertex,r3::Vertex)::Bool

    x,y = point.x,point.y
    x1,y1 = r1.x,r1.y
    x2,y2 = r2.x,r2.y
    x3,y3 = r3.x,r3.y

    l1 = ( (y2-y3)*(x-x3)+(x3-x2)*(y-y3) ) / ( (y2-y3)*(x1-x3) + (x3-x2)*(y1-y3) )
    if (l1 > 1) return false end

    l2 = ( (y3-y1)*(x-x3) + (x1-x3)*(y-y3) ) / ( (y2-y3)*(x1-x3) + (x3-x2)*(y1-y3) )
    if (l2 > 1) return false end

    if (l1+l2 > 1) return false end

    return true
end

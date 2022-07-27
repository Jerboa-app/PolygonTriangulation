#=
    An ear is a convex vertex such that the triangle
    formed by it and it's neighbours contains
    no other vertex

    A convex vertex is has an interior angle < \pi
    formed by the lines to it's neighbours
=#
function isEar(p::Polygon,i::Int)::Bool
    if angleSign(p,i) == Left
        return false
    end

    tri = consecutiveTriple(p,i)

    for v in p.vertices
        if (v != tri[1] && v != tri[2] && v != tri[3])
            if (pointInTriangle(v,tri...))
                return false
            end
        end
    end

    return true
end

function findDiagonal(p::Polygon,i::Int)::Tuple{Int,Int}
    n = length(p)
    a,b,c = consecutiveTriple(p,i)
    bisector = angleBisector(p,i)
    ray = bisector-b
    ray = ray / norm(ray)
    E = edges(p)
    e = nextIndex(i,n) #mod((i-1)+1,n)+1
    seen = 0
    edge = E[e]
    intersection = lineLineSegmentIntersection(b,ray-b,edge[1],edge[2])
    seen += 1
    e+=1
    while (seen < length(E) && intersection == NULL_VERTEX)
        edge = E[e]
        intersection = lineLineSegmentIntersection(b,ray-b,edge[1],edge[2])
        if (intersection == NULL_VERTEX)
            e+=1
            seen += 1
            if (e > length(p)) e = 1 end
        else
            break
        end
    end

    for (v,j) in enumerate(p.vertices)
        if (v == intersection)
            return i,j
        end
    end


    pk = edge[1] # p_{k}
    pk1 = edge[2] # p_{k+1}

    R = Vector{Int}([])
    s = nextIndex(e+1,n) #mod((e-1)+2,n)+1
    while s != i
        if (pointInTriangleInterior(p.vertices[s],b,intersection,pk1))
            push!(R,i)
        end
        s += 1
        if (s > n)
            s = 1
        end
    end

    if (length(R)==0)

        if (pk1 != a)
            return i,nextIndex(e,n)#mod((e-1)+1,n)+1
        end

        #return i,mod((i-1)-1,n)+1

    else
        θs = zeros(length(R))
        for (j,r) in enumerate(R)
            θs[j] = angle(intersection,b,p.vertices[r])
        end

        z = R[argmin(θs)]

        if (z != previousIndex(i,n))
            return i,z
        end
    end

    z = a # p_{i-1}

    S = Vector{Int}([])
    s = nextIndex(i,n) # mod((i-1)+1,n)+1
    while s != mod((e-1),n)+1
        if (pointInTriangleInterior(p.vertices[s],b,intersection,pk))
            push!(S,i)
        end
        s += 1
        if (s > n)
            s = 1
        end
    end

    if (length(S)==0)
        if (pk != c)
            return i,e
        end
    else

        w = c

        θs = zeros(length(S))
        for (j,s) in enumerate(s)
            θs[j] = angle(intersection,b,p.vertices[s])
        end

        w = S[argmin(θs)]

        return i,w

    end

    return i,i

end

function goodSubPolygon(p::Polygon,i::Int,j::Int)::Polygon
    v = []
    k = i
    while k != j
        push!(v,p.vertices[k])
        k+=1
        if (k > length(p))
            k = 1
        end
    end
    push!(v,p.vertices[j])
    return Polygon(v)
end

function findEar(p::Polygon,i::Int)::Int

    if isEar(p,i)
        return i
    end

    i,j = findDiagonal(p,i)

    if (j == i)
        return i
    end

    q = goodSubPolygon(p,i,j)

    return findEar(q,Int(floor(length(q)/2.0)))
end

"""
    meshsegment(L::T, delta::T, udim=2) where T<:Real

"""
function meshsegment(L::T, delta::T, udim=2) where T<:Real

    PT = SVector{udim, T}
    CT = SimplexGraph{2}

    num_segments = ceil(Int, L/delta)
    actual_delta = L/num_segments
    x = collect(0:num_segments) * actual_delta

    vertices = zeros(PT, num_segments+1)
    for i in 1 : length(vertices)
        a = zeros(T, udim)
        a[1] = x[i]
        vertices[i] = PT(a)
    end

    faces = Array{CT}(undef,num_segments)
    for i in 1 : length(faces)
        faces[i] = SimplexGraph(i, i+1)
    end

    Mesh(vertices, faces)
end
  
"""
    meshcircle(radius::T, delta::T, udim=2) where T<:Real

"""
function meshcircle(radius::T, delta::T, udim=2) where T<:Real

    PT = SVector{udim,T}
    # CT = SVector{2,Int}
    CT = SimplexGraph{2}

    circumf = 2 * pi *radius
    num_segments = ceil(Int, circumf / delta)
    delta = circumf / num_segments
    dalpha = delta / radius
    alpha = collect(0 : num_segments-1) * dalpha

    vertices = Array{PT}(undef,num_segments)
    for i in 1 : num_segments
        a = zeros(T, udim)
        a[1] = radius * cos(alpha[i])
        a[2] = radius * sin(alpha[i])
        vertices[i] = PT(a)
    end

    faces = Vector{CT}(undef,num_segments)
    for i in 1 : length(faces)-1
        faces[i] = SimplexGraph(i, i+1)
    end
    faces[end] = SimplexGraph(num_segments, 1)

    return Mesh(vertices, faces)
end

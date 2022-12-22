# https://adventofcode.com/2022/day/8

# input = readlines("2022/testdata/day_8.txt")
input = readlines("2022/data/day_8.txt")

function get_vmat(input)
    h = length(input)
    w = length(input[1])
    vmat = Int.(zeros(h,w))
    for r = 1:h
        for c = 1:w
            vmat[r,c] = parse(Int, input[r][c])
        end
    end
    return vmat
end
function check_right(vmat,r,c)
    # Returns true if the tree is invisible
    if sum(vmat[r,c+1:end] .>= vmat[r,c]) > 0
        return true
    else
        return false
    end
end
function check_left(vmat,r,c)
    # Returns true if the tree is invisible
    if sum(vmat[r,begin:c-1] .>= vmat[r,c]) > 0
        return true
    else
        return false
    end
end
function check_up(vmat,r,c)
    # Returns true if the tree is invisible
    if sum(vmat[begin:r-1,c] .>= vmat[r,c]) > 0
        return true
    else
        return false
    end
end
function check_down(vmat,r,c)
    # Returns true if the tree is invisible
    if sum(vmat[r+1:end,c] .>= vmat[r,c]) > 0
        return true
    else
        return false
    end
end
function check(vec, val)
    if sum(vec .>= val) > 0
        return true
    else
        return false
    end
end
function get_bmat(vmat)
    (h,w) = size(vmat)
    bmat = Int.(ones(h,w)) # Trees that are visible - set invisible to 0
    for r = 2:h-1
        for c = 2:w-1
            if check_right(vmat, r, c) && check_left(vmat, r, c) && check_up(vmat, r, c) && check_down(vmat, r, c)
                bmat[r,c] = 0
            end
        end
    end
    return bmat
end

function part_1(input)
    vmat = get_vmat(input)
    bmat = get_bmat(vmat)
    return sum(sum(bmat))
end
@info part_1(input)

function check_v(v)
    s = 1
    for i = 2:length(v)
        # @show v[i-1:i]
        if v[1] <= v[i] || i == length(v) ## I forgot the or here when we reach the edge
            # @show v,s
            return s
        else
            s += 1
        end 
    end
    # @show v,s
    return s
end

function vizScore!(smat,vmat)
    (h,w) = size(vmat)
    for r ∈ 2:h-1, c ∈ 2:w-1
        smat[r,c] = check_v(vmat[r:-1:begin,c]) * # up 
            check_v(vmat[r,c:-1:begin])    * # left 
            check_v(vmat[r:end,c])         * # down
            check_v(vmat[r,c:end])         # right
    end
end

function part_2(input)
    vmat = get_vmat(input)
    smat = Int.(zeros(size(vmat)))
    vizScore!(smat, vmat)
    # @show smat
    return maximum(smat)
end
@info part_2(input)

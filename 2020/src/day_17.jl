# https://adventofcode.com/2020/day/17
using AdventOfCode

input = readlines("2020/data/day_17.txt")

function parse_input(input)
    sz = (length(input),length(input[1]))
    state = zeros(Int,sz[1]+2,sz[2]+2,3)
    for (i,line) in enumerate(input)
        for c in 1:sz[2]
            # @show i,c,input[i][c]
            if input[i][c] == '.'
                # println("it was .")
                state[i+1,c+1,2] = 0
            else #input[i][c] == '#'
                # println("it was #")
                state[i+1,c+1,2] = 1
            end
        end
    end
    return state
end
state = parse_input(input)

# # Test data:
# #  .#.         010
# #  ..#   ====  001   # original test state
# #  ###         111
# state = zeros(Int,3,3,3)
# state[:,:,2] = [0 1 0; 0 0 1; 1 1 1]

function pad_data(data)
    sz = size(data)
    padded = zeros(Int, sz[1]+2, sz[2]+2, sz[3]+2)
    padded[2:end-1,2:end-1,2:end-1] = data
    return padded
end
# padded = pad_data(data)

function neighbor_sum(data,(i,j,k))
    kernel = ones(Int,3,3,3)
    kernel[2,2,2] = 0
    sz = size(data)
    answer = 0
    for (r,c,h) in Iterators.product((-1+i:1+i),(-1+j:1+j),(-1+k:1+k))
        # @show r,c,h
        if r == i && c == j && h == k
            nothing
        elseif r == 0 || r > sz[1]
            nothing
        elseif c == 0 || c > sz[2]
            nothing
        elseif h == 0 || h > sz[3]
            nothing
        else
            answer += data[r,c,h]
        end
    end
    return answer
end
# @show neighbor_sum(data,(2,2,2))

function cycle(state)
    state = pad_data(state)
    sz = size(state)
    answer = zeros(Int, sz)
    for (i,j,k) in Iterators.product(1:sz[1], 1:sz[2], 1:sz[3])
        nsum = neighbor_sum(state,(i,j,k))
        if state[i,j,k] == 0
            nsum == 3 ? answer[i,j,k] = 1 : answer[i,j,k] = 0
        else # state[i,j,k] == 1
            (nsum == 2 || nsum == 3) ? answer[i,j,k] = 1 : answer[i,j,k] = 0
        end
    end   
    return answer
end
# println(state)
# state1 = cycle(state)
# println(state1)
# state2 = cycle(state1)
# println(state2)
# state3 = cycle(state2)
# println(state3)


function part_1(state)
    for c = 1:6
        state = cycle(state)
    end
    return sum(sum(sum(state)))
end
@info part_1(state)

# @@@@ Part 2 ----- 4 D -----------
# # Test data:
# #  .#.         010
# #  ..#   ====  001   # original test state
# #  ###         111
# state = zeros(Int,3,3,3,3)
# state[:,:,2,2] = [0 1 0; 0 0 1; 1 1 1]
function parse_input4D(input)
    sz = (length(input),length(input[1]))
    state = zeros(Int,sz[1]+2,sz[2]+2,3,3)
    for (i,line) in enumerate(input)
        for c in 1:sz[2]
            # @show i,c,input[i][c]
            if input[i][c] == '.'
                # println("it was .")
                state[i+1,c+1,2,2] = 0
            else #input[i][c] == '#'
                # println("it was #")
                state[i+1,c+1,2,2] = 1
            end
        end
    end
    return state
end
state = parse_input4D(input)

function pad_data4D(data)
    sz = size(data)
    padded = zeros(Int, sz[1]+2, sz[2]+2, sz[3]+2, sz[4]+2)
    padded[2:end-1,2:end-1,2:end-1,2:end-1] = data
    return padded
end
# padded = pad_data(data)

function neighbor_sum4D(data,(i,j,k,l))
    kernel = ones(Int,3,3,3,3)
    kernel[2,2,2,2] = 0
    sz = size(data)
    answer = 0
    for (x,y,z,w) in Iterators.product((-1+i:1+i),(-1+j:1+j),(-1+k:1+k),(-1+l:1+l))
        # @show r,c,h
        if x == i && y == j && z == k && w == l
            nothing
        elseif x == 0 || x > sz[1]
            nothing
        elseif y == 0 || y > sz[2]
            nothing
        elseif z == 0 || z > sz[3]
            nothing
        elseif w == 0 || w > sz[4]
            nothing
        else
            answer += data[x,y,z,w]
        end
    end
    return answer
end
# @show neighbor_sum(data,(2,2,2))

function cycle4D(state)
    state = pad_data4D(state)
    sz = size(state)
    answer = zeros(Int, sz)
    for (i,j,k,l) in Iterators.product(1:sz[1], 1:sz[2], 1:sz[3], 1:sz[4])
        nsum = neighbor_sum4D(state,(i,j,k,l))
        if state[i,j,k,l] == 0
            nsum == 3 ? answer[i,j,k,l] = 1 : answer[i,j,k,l] = 0
        else # state[i,j,k] == 1
            (nsum == 2 || nsum == 3) ? answer[i,j,k,l] = 1 : answer[i,j,k,l] = 0
        end
    end   
    return answer
end
# println(state)
# state1 = cycle4D(state)
# println(state1)
# println(state1)
# state2 = cycle(state1)
# println(state2)
# state3 = cycle(state2)
# println(state3)

function part_2(state)
    for c = 1:6
        state = cycle4D(state)
    end
    return sum(sum(sum(sum(state))))
end
@info part_2(state)

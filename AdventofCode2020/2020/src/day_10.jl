# https://adventofcode.com/2020/day/10
pwd()
using AdventOfCode
using Combinatorics

input = parse.(Int,readlines("2020/data/day_10.txt"))
# input = parse.(Int,readlines("2020/testdata/day_10_1.txt"))
# input = parse.(Int,readlines("2020/testdata/day_10_2.txt"))

sorted = sort(push!(input,0))
sorted = push!(sorted,sorted[end]+3)
# println(sorted)
# println(diff(sorted))
diffsort = diff(sorted)

function part_1(diffsort)
    num_ones = length(findall(x->x==1,diffsort))
    num_threes = length(findall(x->x==3,diffsort))
    return num_ones * num_threes
end
@info part_1(diffsort)


function howMany(me,sorted)
    # Return how many adapters can plug into me (1, 2 or 3)
    if me == length(sorted)
        return 0
    elseif me == length(sorted) - 1 
        return 1
    elseif me == length(sorted) - 2
            return 1
    end
    if sorted[me+3] - sorted[me] <= 3
        return 3
    elseif sorted[me+2] - sorted[me] <= 3
        return 2
    else
        return 1
    end
end

function part_2(sorted)
    # println(sorted)
    comb = 1
    count = 0
    for i in 1:length(sorted)
        if sorted[i] == 1
            count += 1
        else
            if count == 1
                nothing
            elseif count == 2
                println("I'm here")
                comb *= 2
            elseif count == 3
                comb *= 4
            elseif count == 4
                comb *= 7
            end
            count = 0
        end             
    end
    return comb
end
@info part_2(diffsort)
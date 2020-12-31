# https://adventofcode.com/2020/day/15
using AdventOfCode

# input = readlines("2020/data/day_15.txt")
# Examples:
# input = [0,3,6] # Given the starting numbers 0,3,6, the 2020th number spoken is 436.
# input = [1,3,2] # Given the starting numbers 1,3,2, the 2020th number spoken is 1.
# input = [2,1,3] # Given the starting numbers 2,1,3, the 2020th number spoken is 10.
# input = [1,2,3] # Given the starting numbers 1,2,3, the 2020th number spoken is 27.
# input = [2,3,1] # Given the starting numbers 2,3,1, the 2020th number spoken is 78.
# input = [3,2,1] # Given the starting numbers 3,2,1, the 2020th number spoken is 438.
# input = [3,1,2] # Given the starting numbers 3,1,2, the 2020th number spoken is 1836.
#
# The real input:
input = [0,13,1,8,6,15]


x = copy(input)
function part_1(input)
    L0 = length(input)
    for cnt = L0+1:2020
        last = input[end]
        last_loc = findlast(b->b==last,input[1:end-1])
        if last_loc === nothing
            push!(input,0)
        else
            # @show L0,last_loc
            push!(input,L0-last_loc)
        end
        L0 += 1
    end
    return input[L0]
end
@time @info part_1(x)


# input = [0,3,6] # Given 0,3,6, the 30000000th number spoken is 175594.
# Given 1,3,2, the 30000000th number spoken is 2578.
# Given 2,1,3, the 30000000th number spoken is 3544142.
# Given 1,2,3, the 30000000th number spoken is 261214.
# Given 2,3,1, the 30000000th number spoken is 6895259.
# Given 3,2,1, the 30000000th number spoken is 18.
# Given 3,1,2, the 30000000th number spoken is 362.

# x = Dict(input[1]=>1)
# for i in zip(2:length(input),input[2:end])
#     x[i[2]] = i[1]
# end
x = Dict(i[1] => [i[2],-1] for i in zip(input,1:length(input)))

function part_2(input,last)
    L0 = input[last][1]
    for cnt = L0+1:30000000
        if input[last][2] == -1 # It was just called for the first time
            last = 0
        else            
            last = input[last][1] - input[last][2]
        end
        if haskey(input, last)
            input[last] = [cnt, input[last][1]]
        else
            input[last] = [cnt, -1]
        end
        # @show x
    end
    return last
end
@time @info part_2(x,input[end])

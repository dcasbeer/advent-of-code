# https://adventofcode.com/2020/day/9
using AdventOfCode
using Combinatorics

input = parse.(Int,readlines("2020/data/day_9.txt")); preambleLength = 25
# input = parse.(Int,readlines("2020/testdata/day_9.txt")); preambleLength = 5

function checkIfValid(input,num,pstart::Int64,plength::Int64)
    return num in [sum(c) for c in combinations(input[pstart:plength+pstart],2)]
end

function part_1(input,preambleLength)
    for α in preambleLength+1:length(input)
        # println("part_1: ",α," ", input[α], " ", preambleLength)
        if !checkIfValid(input, input[α], α-preambleLength, preambleLength)
            println("Invalid")
            return input[α]
        end
    end
end
@run answer = part_1(input, preambleLength)
@info answer

function part_2(input,part1_answer)
    ind = findfirst(x -> x==part1_answer, input)
    for l = 2:ind-1
        for i = 1:ind-l
            # println(i, " ", i+l-1)
            if sum(input[i:i+l-1]) == part1_answer
                r = input[i:i+l-1]
                return minimum(r) + maximum(r)
            end
        end
    end
end
@info part_2(input, answer)


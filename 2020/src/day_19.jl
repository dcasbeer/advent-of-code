# https://adventofcode.com/2020/day/19
using AdventOfCode

input = readlines("2020/data/day_19.txt")
input = readlines("2020/testdata/day_19.txt")

function get_rules(input)
    fin = findfirst(input .== "")
    answer = Dict{String,Array{String,1}}()
    for l ∈ input[1:fin-1]
        colon = findfirst(":", l)[1]    
        tmp = split(l[colon+2:end])
        sp = Array{String,1}(undef,length(tmp))
        for (i,l) ∈ enumerate(tmp)
            sp[i] = string(l)
        end
        if sp[1][1] == '\"'
            push!(answer, l[1:colon-1] => [sp[1][2:2]])
        else
            push!(answer, l[1:colon-1] => sp)
        end
    end
    return answer
end
rules = get_rules(input)

function part_1(input)
    nothing
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

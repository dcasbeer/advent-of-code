# https://adventofcode.com/2020/day/18
using AdventOfCode

input = readlines("2020/data/day_18.txt")

# # test input
# input = [ "2 * 3 + (4 * 5)", # becomes 26.
#           "5 + (8 * 3 + 9 + 3 * 4 * 3)", # becomes 437.
#           "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))", # becomes 12240.
#           "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"] # becomes 13632.

function parse_exp(line)
    # All the numbers are single digit
    # println("Starting parse_exp with: ", line)
    subline = line
    f = findfirst(")", subline)
    while f ≠ nothing
        f = f[1]
        s = findlast("(", subline[1:f])
        s = s[1]
        subline = subline[1:s-1] * parse_exp(subline[s+1:f-1]) * subline[f+1:end]
        f = findfirst(")", subline)
    end
    # println("Parsing the substring: ", subline)
    sp = split(subline)
    value = parse(Int,sp[1])
    for (i,c) in enumerate(sp)
        # @show i, c, value
        if c == "+"
            value += parse(Int, sp[i+1])
        elseif c == "*"
            # @show c, sp[i+1]
            value *= parse(Int, sp[i+1])
        else 
            nothing
        end
    end
    # @show value
    return string(value)
end
# @info parse_exp(input[4])


function part_1(input)
    answer = 0
    for l in input
        answer += parse(Int,parse_exp(l))
    end
    return answer
end
@info part_1(input)

## @@@ Part 2 - Now + has precedence over *
# test input
# input = [ "2 * 3 + (4 * 5)", # becomes 26.
#           "5 + (8 * 3 + 9 + 3 * 4 * 3)", # becomes 437.
#           "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))", # becomes 12240.
#           "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"] # becomes 13632.

function parse_exp2(line)
    # All the numbers are single digit
    # println("Starting parse_exp with: ", line)
    subline = line
    f = findfirst(")", subline)
    while f ≠ nothing
        f = f[1]
        s = findlast("(", subline[1:f])
        s = s[1]
        subline = subline[1:s-1] * parse_exp2(subline[s+1:f-1]) * subline[f+1:end]
        f = findfirst(")", subline)
    end
    # println("Parsing the substring: ", subline)
    tmp = split(subline)
    sp = Array{String,1}(undef,length(tmp))
    for (i,l) ∈ enumerate(tmp)
        sp[i] = string(l)
    end
    f = findfirst(sp .== "+")
    while f ≠ nothing
        v = string(parse(Int,sp[f-1]) + parse(Int,sp[f+1]))
        splice!(sp, f-1:f+1, [v])
        f = findfirst(sp .== "+")
    end
    f = findfirst(sp .== "*")
    while f ≠ nothing
        v = string(parse(Int,sp[f-1]) * parse(Int,sp[f+1]))
        splice!(sp, f-1:f+1, [v])
        f = findfirst(sp .== "*")
    end
    # @show value
    return sp[1]
end
# @info parse_exp2(input[1])
# @info parse_exp2(input[2])
# @info parse_exp2(input[3])
# @info parse_exp2(input[4])

function part_2(input)
    answer = 0
    for l in input
        answer += parse(Int,parse_exp2(l))
    end
    return answer
end
@info part_2(input)

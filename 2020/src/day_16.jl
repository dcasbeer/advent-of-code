# https://adventofcode.com/2020/day/16
using AdventOfCode

input = readlines("2020/data/day_16.txt")

function get_data_ranges(input)
    type = 'F'
    i = 1
    rules = -1:0
    nrange = -1:0
    my_ticket = -1
    while type != 'N'
        # println(input[i])
        # println(input[i] == "your ticket:")
        if input[i] == "your ticket:"
            type = 'Y'
            my_ticket = i+1
            rules = 1:i-2
        elseif input[i] == "nearby tickets:"
            type = 'N'
            nrange = i+1:length(input)
        end
        i += 1
    end
    return rules,my_ticket,nrange
end
data_ranges = get_data_ranges(input) # (rules, my_ticket, neighbor_tickets)

function define_valid_ranges(input,rule_range)
    valid_ranges = Dict()
    for i in rule_range
        s = split(input[i], ": ")
        rs = split(s[2], " or ")
        r1 = split(rs[1], "-")
        r2 = split(rs[2], "-")
        valid_ranges[s[1]] = [parse(Int64, r1[1]):parse(Int64, r1[2]) , parse(Int64, r2[1]):parse(Int64, r2[2])]
    end
    return valid_ranges
end
valid_ranges = define_valid_ranges(input,data_ranges[1])

function is_valid_range(valid_ranges,num)
    answer = false
    for vr in valid_ranges
        if num ∈ vr[2][1] || num ∈ vr[2][2]
            return true
        end            
    end
    return answer
end
# @show is_valid_range(valid_ranges,40)

function part_1(input)
    data_ranges = get_data_ranges(input) # (rules, my_ticket, neighbor_tickets)
    valid_ranges = define_valid_ranges(input,data_ranges[1]) # Dict: keys - rule name ; values - ranges
    answer = []
    legit_tickets = []
    for i ∈ data_ranges[3]
        isvalid = true
        for num ∈ split(input[i], ",")
            n = parse(Int64, num)
            if !is_valid_range(valid_ranges, n)
                push!(answer,n)
                isvalid = false
            end
        end
        if isvalid
            push!(legit_tickets, i)
        end
    end
    # @show answer
    return sum(answer), legit_tickets
end
lt = part_1(input)
@info lt[1]

function get_data_matrix(input,legit_tickets,dr)
    answer =  Array{Int64,2}(undef, length(legit_tickets), dr.stop) 
    r,c = 1,1
    for lt ∈ zip(1:length(legit_tickets),legit_tickets)
        r = lt[1]
        for num ∈ zip(1:20,split(input[lt[2]], ","))
            c = num[1]
            # @show r,c, num[2]
            answer[r,c] = parse(Int64,num[2])
        end
    end
    return answer
end
dm = get_data_matrix(input,lt[2],data_ranges[1])

function all_match(dm, col, vr, type, could_be)
    answer = true
    for c in dm[:,col]
        if c ∉ vr[type][1] && c ∉ vr[type][2]
            answer = false
            delete!(could_be[col], type)
        end
    end
    return answer
end

function part_2(input)
    data_ranges = get_data_ranges(input) # (rules, my_ticket, neighbor_tickets)
    valid_ranges = define_valid_ranges(input,data_ranges[1]) # Dict: keys - rule name ; values - ranges
    dm = get_data_matrix(input,lt[2],data_ranges[1])
    could_be = Dict()
    must_be = -1
    designated = Set()
    for c in 1:20 # Dictionary defining what the column could be
        could_be[c] = Set(keys(valid_ranges))
    end
    for c in 1:20
        for k in keys(valid_ranges)
            all_match(dm,c,valid_ranges,k,could_be)
        end
        if length(could_be[c]) == 1
            must_be = c
            designated = union(designated, could_be[c])
        end
    end
    for cnt ∈ 2:100 
        for c in 1:20
            if length(could_be[c]) >= 2
                if length(could_be[c]) == 2
                    # println("\n** New Col ** ")
                    # @show c,designated
                    # @show could_be[c]
                    could_be[c] = setdiff(could_be[c], designated)
                    designated = union(designated, could_be[c])
                    # @show designated 
                    # @show could_be[c]
                else
                    could_be[c] = setdiff(could_be[c], designated)
                    if length(could_be[c]) == 1
                        designated = union(designated, could_be[c])
                    end
                end 
           end
        end
    end
    answer = 1
    for c in 1:20 
        if "departure time" ∈ out[c]
            @show c
        elseif "departure date" ∈ out[c]
            @show c
        elseif "departure track" ∈ out[c]
            @show c
        elseif "departure platform" ∈ out[c]
            @show c
        elseif "departure station" ∈ out[c]
            @show c
        elseif "departure location" ∈ out[c]
            @show c
        end
    end
    return answer
end
@info part_2(input)
## The answer is the product of the values on "my ticket" for the c values listed
# julia> 193*59*61*79*83*113
# 514662805187
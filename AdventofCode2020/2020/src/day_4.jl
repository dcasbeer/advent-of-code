# https://adventofcode.com/2020/day/4
using AdventOfCode

input = readlines("2020/testdata/day_4.txt")
# input = readlines("2020/data/day_4.txt")
input = append!(input,[""]) # I need this so I check the last card

function checkID(x)
    # println(x)
    if occursin(r"byr:",x) && occursin(r"iyr:",x) && occursin(r"eyr:",x) && occursin(r"hgt:",x) && occursin(r"hcl:",x) && occursin(r"ecl:",x) && occursin(r"pid:",x)
        # println("This is valid")
        return 1
    else
        # println("This is not valid")
        return 0
    end
end
println("\n****** Starting Part 1 ******")

function part_1(input)
    alldata = ""
    valid_count = 0
    for line in input
        if line == ""
            valid_count += checkID(alldata)
            alldata = ""
        else
            alldata = alldata * " " * line
        end
    end
    return valid_count
end
@info part_1(input)


println("****** Starting Part 2 ******")
# input = readlines("2020/testdata/day_4_2valid.txt")
# input = readlines("2020/testdata/day_4_2invalid.txt")
input = readlines("2020/data/day_4.txt")
input = append!(input,[""]) # I need this so I check the last card

function checkrange(v)
    if v[1] == "byr"
        intv = parse.(Int64,v[2])
        if intv >= 1920 && intv <= 2002
            return 1
        end
    elseif v[1] == "iyr"
        intv = parse.(Int64,v[2])
        if intv >= 2010 && intv <= 2020
            return 1
        end
    elseif v[1] == "eyr"
        intv = parse.(Int64,v[2])
        if intv >= 2020 && intv <= 2030
            return 1
        end
    elseif v[1] == "hgt"
        if v[2][end-1:end] == "cm"
            if length(v[2]) == 5
                intv = parse.(Int64,v[2][1:3])
                if intv >= 150 && intv <= 193
                    return 1
                end
            end
        elseif v[2][end-1:end] == "in"
            if length(v[2]) == 4
                intv = parse.(Int64,v[2][1:2])
                if intv >= 59 && intv <= 76
                    return 1
                end
            end
        end
    elseif v[1] == "hcl"
        if v[2][1] != "#" && length(v[2]) != 7
            return 0
        else
            for digit in v[2][2:end]
                chars = ['a','b','c','d','e','f','0','1','2','3','4','5','6','7','8','9']
                if digit ∉ chars
                    return 0
                end
            end
            return 1
        end
    elseif v[1] == "ecl"
        if v[2] == "amb" || v[2] == "blu" || v[2] == "brn" || v[2] == "gry" || v[2] == "grn" || v[2] == "hzl" || v[2] == "oth"
            return 1
        end
    elseif v[1] == "pid"
        if length(v[2]) == 9
            for digit in v[2]
                chars = ['0','1','2','3','4','5','6','7','8','9']
                if digit ∉ chars
                    return 0
                end
            end
            return 1
        end
    else
        return 1
    end
    return 0
end

function checkIDvalues(id)
    if checkID(id) == 1
        # It has all required fields: now check if they are within parameters
        IDv = split(id)
        dvals = Dict(split(val,":")[1] => split(val,":")[2] for val in IDv)
        for v in dvals
            if checkrange(v) == 0
                return 0
            end
        end
    else
        return 0 # it doesn't have all required fields
    end
    return 1
end

function part_2(input)
    alldata = ""
    valid_count = 0
    for line in input
        if line == ""
            println(alldata)
            valid_count += checkIDvalues(strip(alldata))
            alldata = ""
        else
            alldata = alldata * " " * line
        end
    end
    return valid_count
end
@info part_2(input)

# https://adventofcode.com/2020/day/2
using AdventOfCode

input = readlines("2020/data/day_2.txt")
# input = readlines("2020/testdata/day_2.txt")

println("\n----------- Starting Part 1")
function part_1(input)
    good_passwords = 0
    for line in input
        sline = split(line,":")
        rule = split(sline[1])
        letter = rule[2]
        min_max = split(rule[1],"-")
        # print(sline[2],"\n")
        # print(Regex(letter),"\n")
        password_array = Array(split(sline[2],""))
        # print(password_array,"\n")
        lcount = count(i->(i==letter),password_array)
        if parse(Int64,min_max[1]) <= lcount && lcount <= parse(Int64,min_max[2])
            good_passwords = good_passwords + 1
        end
    end
    return good_passwords
end
@info part_1(input)

println("\n----------- Starting Part 2")
function part_2(input)
    good_passwords = 0
    for line in input
        sline = split(line,":")
        rule = split(sline[1])
        letter = rule[2][1]
        pos = split(rule[1],"-")
        p1 = parse(Int64,pos[1])
        p2 = parse(Int64,pos[2])
        password = strip(sline[2])
        # println(typeof(password[p1]))
        # println(typeof(letter[1]))
        # println(password[p1] == letter)
        if password[p1] == letter
            if password[p2] != letter
                good_passwords = good_passwords + 1
            end
        elseif password[p2] == letter
            good_passwords = good_passwords + 1
        end
        # lcount = count(i->(i==letter),password_array)
        # if parse(Int64,min_max[1]) <= lcount && lcount <= parse(Int64,min_max[2])
        #     good_passwords = good_passwords + 1
        # end
    end
    return good_passwords
end
@info part_2(input)

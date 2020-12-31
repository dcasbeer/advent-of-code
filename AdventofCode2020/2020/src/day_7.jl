# https://adventofcode.com/2020/day/7
using AdventOfCode

input = readlines("2020/data/day_7.txt")
# input = readlines("2020/testdata/day_7.txt")


# ***** Helper Function *************
line1 = input[2]
function get_bagType(line)
    bagsIndRange = findnext(" bag", line, 1)
    indRange = 1:bagsIndRange[1]-1
    return line[indRange]
end
# println(get_bagType(line1))

function get_contents(line)
    bagsIndRange = findnext("contain", line, 1)
    bags = split(line[bagsIndRange[end]+1:end],",")
    num_contents = length(bags)
    d = Dict()
    for b in bags
        # println(split(b," "))
        breakdown = split(b," ")
        if breakdown[2] == "no"
            breakdown[2] = "0"
            breakdown[3] = "None"
        end
        amount = parse(Int64,breakdown[2])
        # println(typeof(breakdown[3]))
        type = breakdown[3]
        for word in breakdown[4:end-1]
            type = type * " " * word
        end
        push!(d, type => amount)
    end
    return d
end
# println(get_contents(line1))

function whatCanHold(input)
    function getAllBagTypes(input)
        # Returns a dictionary with keys for all bag types
        list = Dict()
        for line in input
            type = get_bagType(line)
            push!(list, type => Dict())
        end
        return list
    end

    list = getAllBagTypes(input)
    for line in input
        type = get_bagType(line)
        contents = get_contents(line)
        list[type] = merge(list[type],contents)
    end
    # addedSomething = true
    # while addedSomething
    #     addedSomething = false
    #
    # end
    return list
end
# list = whatCanHold(input)
# print(whatCanHold(input))

### ***** Part 1 **********************************
function whoHoldsMe(me,list)
    # Find which bags hold "me" (input)
    answer = Set()
    for k in keys(list)
        if me ∈ keys(list[k])
            # println(me," ",k," ",answer)
            if k in answer
                return
            end
            answer = union(answer, [k])
            # println("me(",me,") is held by ", k)
        end
    end
    # println(union(answer,[me]))
    return union(answer )
end
function searchWhatHolds(me, start, path, list)
    answer = union(path,[me])
    for k in whoHoldsMe(me,list)
        # println(" start: ", me, " k: ",k,)
        if k ∈ answer
            nothing
        else
            answer = union(searchWhatHolds(k, start, answer, list), answer)
        end
    end
    return answer
end
# list = whatCanHold(input) # All bags and what they directly hold
# println(whoHoldsMe("shiny gold",list))
# println(searchWhatHolds("shiny gold", "shiny gold", Set(), list))

function part_1(input)
    list = whatCanHold(input) # All bags and what they directly hold
    # println(whoHoldsMe("shiny gold",list))
    answer_1 = searchWhatHolds("shiny gold", "shiny gold", Set(), list)
    # println(answer_1)
    return length(answer_1) - 1
end
# list = whatCanHold(input)
@info part_1(input)

# ***************** Part 2 **************************************
# input = readlines("2020/testdata/day_7_2.txt")
# input = readlines("2020/testdata/day_7.txt")

function searchHowMany(me, list)
    contains = 0
    for k in keys(list[me])
        if k == "None"
            return 0
        else
            # println("Before*** me: ", me, " k: ", k)
            contains = contains + list[me][k] + list[me][k]*searchHowMany(k,list)
            # println(list[me][k], " + ", list[me][k], "* search = ", contains)
            # println("After*** me: ", me, " k: ", k, " contains: ", contains)
        end
    end
    return contains
end
# list = whatCanHold(input)
# println(searchHowMany("shiny gold", list))


function part_2(input)
    list = whatCanHold(input)
    return searchHowMany("shiny gold", list)
end
@info part_2(input)

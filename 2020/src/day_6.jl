# https://adventofcode.com/2020/day/6
using AdventOfCode

input = readlines("2020/data/day_6.txt")
# input = readlines("2020/testdata/day_6.txt")

function groupSum(groupData)
    # Count how many questions someone in this group answered yes
    # Create a set with the values
    s = Set(groupData[1])
    for ind in 2:length(groupData)
        s = union(s,groupData[ind])
    end
    # println(groupData, "Length s: ", length(s))
    return length(s)
end

function part_1(input)
    count = 0
    gaps = findall(x->x=="", input)
    groupIndBeg = pushfirst!(gaps.+1,1)
    groupIndEnd = push!(gaps.-1,length(input))
    for ind in 1:length(groupIndEnd)
        count += groupSum(input[groupIndBeg[ind]:groupIndEnd[ind]])
    end
    return count
end
@info part_1(input)

function groupAllSum(groupData)
    # Count how many questions someone in this group answered yes
    # Create a set with the values
    s = Set(groupData[1])
    for ind in 2:length(groupData)
        s = intersect(s,groupData[ind])
    end
    # println(groupData, "Length s: ", length(s))
    return length(s)
end

# input = readlines("2020/testdata/day_6.txt")
function part_2(input)
    count = 0
    gaps = findall(x->x=="", input)
    groupIndBeg = pushfirst!(gaps.+1,1)
    groupIndEnd = push!(gaps.-1,length(input))
    for ind in 1:length(groupIndEnd)
        count += groupAllSum(input[groupIndBeg[ind]:groupIndEnd[ind]])
    end
    return count
end
@info part_2(input)

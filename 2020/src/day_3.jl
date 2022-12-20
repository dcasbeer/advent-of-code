# https://adventofcode.com/2020/day/3
using AdventOfCode

input = readlines("2020/data/day_3.txt")
# input = readlines("2020/testdata/day_3.txt")

# println(input[2][2]) # I can call the locations directly from here
# println(length(input[1]))
function wrapInd(val,width)
    return ((val-1) % width) + 1
end
# println(wrapInd(11,10))

function findtrees(input,rise,run)
    x = 1
    y = 1
    treecount = 0
    while y <= length(input)
        if input[y][x] == '#'
            treecount += 1
        end
        x = wrapInd(x + run,length(input[1]))
        y += rise
    end
    return treecount
end

function part_1(input)
    rise = 1
    run = 3
    return(findtrees(input,rise,run))
end
@info part_1(input)

function part_2(input)
    treeproduct = 1
    rise = 1
    run = 1
    treeproduct *= findtrees(input,rise,run)
    rise = 1
    run = 3
    treeproduct *= findtrees(input,rise,run)
    rise = 1
    run = 5
    treeproduct *= findtrees(input,rise,run)
    rise = 1
    run = 7
    treeproduct *= findtrees(input,rise,run)
    rise = 2
    run = 1
    treeproduct *= findtrees(input,rise,run)
    return treeproduct
end
@info part_2(input)

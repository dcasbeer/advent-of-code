# https://adventofcode.com/2022/day/4

# input = readlines("2022/testdata/day_4.txt")
input = readlines("2022/data/day_4.txt")

function fully_contained(line)
    c = findall(',', line)[1]
    i1,i2 = findall('-',line)
    # @show(c,i1,i2)
    nothing
    min1 = parse(Int64,line[begin:i1-1])
    max1 = parse(Int64,line[i1+1:c-1])
    min2 = parse(Int64,line[c+1:i2-1])
    max2 = parse(Int64,line[i2+1:end])
    # @show(min1,max1,min2,max2)
    if (min1 >= min2 && max1 <= max2) || (min2 >= min1 && max2 <= max1)
        return 1
    else
        return 0
    end
end
# @info fully_contained(input[2])

function part_1(input)
    return sum(fully_contained.(input))
end
@info part_1(input)

function overlap(line)
    c = findall(',', line)[1]
    i1,i2 = findall('-',line)
    # @show(c,i1,i2)
    nothing
    min1 = parse(Int64,line[begin:i1-1])
    max1 = parse(Int64,line[i1+1:c-1])
    min2 = parse(Int64,line[c+1:i2-1])
    max2 = parse(Int64,line[i2+1:end])
    # @show(min1,max1,min2,max2)
    if (min1 > max2) || (min2 > max1)
        return 0
    else
        return 1
    end
end

function part_2(input)
    return sum(overlap.(input))
end
@info part_2(input)

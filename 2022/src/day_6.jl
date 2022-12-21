# https://adventofcode.com/2022/day/6

# input = readlines("2022/testdata/day_6.txt")
input = readlines("2022/data/day_6.txt")


function part_1(input)
    for i = 1:length(input)-3
        # @show i:i+3
        if 4 == length(unique(input[i:i+3]))
            return i+3
        end
    end
end
@info part_1(input[1])

# input = readlines("2022/testdata/day_6.txt")

function part_2(input)
    for i = 1:length(input)-13
        if 14 == length(unique(input[i:i+13]))
            return i+13
        end
    end
end
@info part_2(input[1])

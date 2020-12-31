# https://adventofcode.com/2020/day/5
using AdventOfCode

input = readlines("2020/data/day_5.txt")
# input = readlines("2020/testdata/day_5.txt")

function findrow(rowData)
    # Bisection search for row
    min = 0
    max = 127
    for c in rowData
        if c == 'F'
            max = min + floor(Int,(max-min)/2)
        else # rowData == 'B'
            min = max - floor(Int,(max-min)/2)
        end
    end
    if min != max
        error(rowData, " min: ", min, " max: ", max, "not equal")
    else
        return max
    end
end

function findcolumn(cData)
    # Bisection search for column
    min = 0
    max = 7
    for c in cData
        if c == 'L'
            max = min + floor(Int,(max-min)/2)
        else # rowData == 'B'
            min = max - floor(Int,(max-min)/2)
        end
    end
    if min != max
        error(cData, " min: ", min, " max: ", max, "not equal")
    else
        return max
    end
end

function part_1(input)
    max_seatID = 0
    for line in input
        rowData = line[1:7]
        columnData = line[8:10]
        row = findrow(rowData)
        column = findcolumn(columnData)
        # println(row, ", ", column)
        seatID = row * 8 + column
        # println(seatID)
        if seatID > max_seatID
            max_seatID = seatID
        end
    end
    return max_seatID
end
@info part_1(input)

# input = readlines("2020/testdata/day_5.txt")
function part_2(input)
    seats = zeros(Int,128*8,1)
    for line in input
        rowData = line[1:7]
        columnData = line[8:10]
        row = findrow(rowData)
        column = findcolumn(columnData)
        seatID = row * 8 + column
        seats[seatID] = 1
    end
    for cnt in 2:length(seats)-1
        if seats[cnt] == 0 && seats[cnt-1] == 1 && seats[cnt+1] == 1
            return cnt
        end
    end
    nothing
end
@info part_2(input)

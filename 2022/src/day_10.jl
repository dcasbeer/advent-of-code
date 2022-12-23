# https://adventofcode.com/2022/day/10

# input = readlines("2022/testdata/day_10.txt")
# input = readlines("2022/testdata/day_10v2.txt")
input = readlines("2022/data/day_10.txt")


# for x = 1:100
#     val = (x-20) / 40
#     @show x, val, ceil(val), ceil(val) == val
# end

# for x = 1:100
#     cpos = (x-1) % 40
#     @show cpos, trunc(Int, (x-1)/40)
# end

function part_1(input)
    X = 1
    cycle = 1
    idx = 1
    cmd = ""
    addx = 0
    count = 0
    values = []
    screen = Matrix{Char}(undef, 6,40) 
    while true
        if count == 0
            # implement command
            if cmd == "addx"
                X += addx
            end
            # @show cycle, X, count
            if idx <= length(input) # data to read
                row = input[idx]
                idx += 1
                cmd = row[1:4]
                if cmd == "noop"
                    count = 1
                    addx = 0
                else # cmd = addx
                    count = 2
                    addx = parse(Int, row[6:end])
                end
            else
                return sum(values), screen
            end
        else
            # @show cycle, X, count
        end
        test = (cycle - 20) / 40
        if ceil(test) == test
            push!(values, X*cycle)
        end
        
        # Draw the image
        CRTpos = (cycle - 1) % 40
        CRTrow = trunc(Int, (cycle-1)/40)
        spos = X
        if abs(CRTpos - spos) <= 1
            screen[CRTrow+1,CRTpos+1] = '#'
        else
            screen[CRTrow+1,CRTpos+1] = '.'
        end

        cycle += 1
        count -= 1
    end
end
sv, screen = part_1(input)
@info sv

function get_char(c)
    if c == 1
        return '#'
    elseif c == 0
        return '.'
    end
end
function part_2(sv)
    open("./2022/src/day_10_solution.txt", "w") do io
        for line in eachrow(sv)
            @show join(line)
            println(io, join(line))
        end
    end
end
@info part_2(screen)

# https://adventofcode.com/2020/day/12
using AdventOfCode

input = readlines("2020/data/day_12.txt")
# input = readlines("2020/testdata/day_12.txt")

# state = Array{Union{Int64,Float64}}(undef,3)
state = Array{Int64}(undef,3)
state[1] = 0   # x (EW) Position
state[2] = 0   # y (NS) Position
state[3] = 0 # East (N is 90)

function move(state,cmd)
    if cmd[1] == 'N'
        state[2] += parse(Int64,cmd[2:end])
    elseif cmd[1] == 'S'
        state[2] -= parse(Int64,cmd[2:end])
    elseif cmd[1] == 'E'
        state[1] += parse(Int64,cmd[2:end])
    elseif cmd[1] == 'W'
        state[1] -= parse(Int64,cmd[2:end])
    elseif cmd[1] == 'L'
        state[3] = mod(state[3] + parse(Int64,cmd[2:end]),360)
    elseif cmd[1] == 'R'
        # println("Moving Right: ", cmd[2:end])
        state[3] = mod(state[3] - parse(Int64,cmd[2:end]), 360)
        # println(state[3])
    elseif cmd[1] == 'F'
        if state[3] == 0 || state[3] == 360
            state[1] += parse(Int64,cmd[2:end]) # Move East
        elseif state[3] == 90
            state[2] += parse(Int64,cmd[2:end]) # Move North
        elseif state[3] == 180
            state[1] -= parse(Int64,cmd[2:end])
        elseif state[3] == 270
            state[2] -= parse(Int64,cmd[2:end])
        end
    end
end

function part_1(state,input)
    # println(state)
    for line in input
        move(state,line)
        # println(state)
    end
    return abs(state[1]) + abs(state[2])
end
@info part_1(state,input)

# state = Array{Union{Int64,Float64}}(undef,3)
state = Array{Int64}(undef,2)
state[1] = 0   # x (EW) Position
state[2] = 0   # y (NS) Position
wp = Array{Int64}(undef,2)
wp[1] = 10
wp[2] = 1

function move2(state,wp,cmd)
    if cmd[1] == 'N'
        wp[2] += parse(Int64,cmd[2:end])
    elseif cmd[1] == 'S'
        wp[2] -= parse(Int64,cmd[2:end])
    elseif cmd[1] == 'E'
        wp[1] += parse(Int64,cmd[2:end])
    elseif cmd[1] == 'W'
        wp[1] -= parse(Int64,cmd[2:end])
    elseif cmd[1] == 'L'
        deg = parse(Int64,cmd[2:end])
        wp1,wp2 = wp[1],wp[2]
        if deg == 0 || deg == 360
            nothing
        elseif deg == 90
            wp[1] = -wp2
            wp[2] = wp1
        elseif deg == 180 
            wp[1] = -wp1
            wp[2] = -wp2
        elseif deg == 270
            wp[1] = wp2
            wp[2] = -wp1
        end
    elseif cmd[1] == 'R'
        deg = parse(Int64,cmd[2:end])
        wp1,wp2 = wp[1],wp[2]
        if deg == 0 || deg == 360
            nothing
        elseif deg == 90
            wp[1] = wp2
            wp[2] = -wp1
        elseif deg == 180 
            wp[1] = -wp1
            wp[2] = -wp2
        elseif deg == 270
            wp[1] = -wp2
            wp[2] = wp1
        end
    elseif cmd[1] == 'F'
        for i in 1:parse(Int64,cmd[2:end])
            state[1] += wp[1]
            state[2] += wp[2]
        end
    end
end
function part_2(input)
    # println(state)
    for line in input
        move2(state,wp,line)
        # println(state)
    end
    return abs(state[1]) + abs(state[2])
end
@info part_2(input)

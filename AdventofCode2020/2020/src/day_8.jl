# https://adventofcode.com/2020/day/8
using AdventOfCode

input = readlines("2020/data/day_8.txt")
# input = readlines("2020/testdata/day_8.txt")

# ***** Helper Function *************
line1 = input[2]
function get_instruction(line)
    command = split(line)
    return (command[1], parse(Int64, command[2]))
end
# println(get_instruction(line1))

mutable struct myBootCode
    acc::Int64
    line::Int64
    beenThere::Set
    done::Bool
end
function visitedBefore(bc::myBootCode,newline)
    if newline ∈ bc.beenThere
        bc.done = true
    end    
end
function accumulator(bc::myBootCode,input)
    visitedBefore(bc,bc.line+1)
    if bc.done == true
        nothing
    else
        bc.acc += input
        bc.line += 1
        bc.beenThere = union(bc.beenThere,[bc.line])
    end
end
function jump(bc::myBootCode,input)
    visitedBefore(bc,bc.line+1)
    if bc.done == true
        nothing
    else
        bc.line += input
    end
end
function noOP(bc::myBootCode)
    visitedBefore(bc,bc.line+1)
    if bc.done == true
        nothing
    else
        bc.line += 1
    end
end



function part_1(input)
    bc = myBootCode(0,1,Set([1]),false)
    while !bc.done
        instruction = get_instruction(input[bc.line])
        if instruction[1] == "acc"
            accumulator(bc, instruction[2])
        elseif instruction[1] == "jmp"
            jump(bc, instruction[2])
        else 
            noOP(bc)
        end
    end
    return bc.acc
end
@info part_1(input)

# input = readlines("2020/testdata/day_8.txt")
function part_2(input)
    count = 1
    while true # A more intuitive way to do this would have been to just iterate through the input list changing them each time.
        bc = myBootCode(0,1,Set([1]),false)
        c = 1
        while !bc.done && (bc.line <= length(input)) 
            instruction = get_instruction(input[bc.line])
            if instruction[1] == "acc"
                accumulator(bc, instruction[2])
            elseif instruction[1] == "jmp"
                c += 1
                if count == c
                    noOP(bc)
                else
                    jump(bc, instruction[2])
                end
            else 
                c += 1
                if count == c
                    jump(bc, instruction[2])
                else
                    noOP(bc)
                end
            end
        end
        if bc.line == length(input) + 1
            println(count)
            return bc.acc
        end
        count += 1
    end
end
@info part_2(input)

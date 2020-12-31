# https://adventofcode.com/2020/day/11
using AdventOfCode

input = readlines("2020/data/day_11.txt")
# input = readlines("2020/testdata/day_11.txt")

function sumNeighbors(r,c,sk,input)
    answer = 0
    for i in -1:1
        # println("(r,i): (",r+i,",",i,")")
        if r+i ∈ 1:length(input)
            for j in -1:1
                # println("B(r,c): (",r+i,",",c+j,")")
                if c+j ∈ 1:length(input[1]) && input[r+i][c+j] != '.' && (i !=0 || j != 0)
                    # println("A(r,c): (",r+i,",",c+j,")")
                    answer += sk[r+i,c+j]
                end
            end
        end
    end
    return answer
end

function seatCustomers(sk,skp1,input)
    # println("NewStart seatCustomers")
    for r in 1:length(input)
        for c in 1:length(input[1])
            if input[r][c] != '.'
                sumN = sumNeighbors(r,c,sk,input)
                if r == 9
                    # println("(r,c,sumN): (",r,",",c,",",sumN,")")
                end
                if sk[r,c] == 0 && sumN == 0
                    skp1[r,c] = 1
                elseif sk[r,c] == 1 && sumN >= 4
                    skp1[r,c] = 0
                end
            end
        end
    end
end


function part_1(input)
    sk = zeros(Int8,length(input),length(input[1])); sk[1,1] = 1
    skp1 = zeros(Int8,length(input),length(input[1]))
    while sk != skp1
        sk = copy(skp1)
        seatCustomers(sk,skp1,input)
    end
    return sum(sum(skp1))
end
@info part_1(input)


function OutofBound(r,c,input)
    if r < 1 || r > length(input)
        return true
    elseif c < 1 || c > length(input[1])
        return true
    else
        return false
    end
end
function isSeat(r,c,input)
    if !OutofBound(r,c,input)
        if input[r][c] == '.'
            return false
        else
            return true
        end
    else
        return false
    end
end
function test2(sk,input)
    # Used to modify sk to read the second test input
    for r in 1:length(input), c in 1:length(input[1])
        if input[r][c] == '#'
            sk[r,c] = 1
        end
    end
end

function sumVisible(r,c,sk,input)
    answer = 0
    for dr in -1:1, dc in -1:1
        if dr != 0 || dc != 0
            x,y = r+dr,c+dc
            while !OutofBound(x,y,input) && !isSeat(x,y,input)
                # println("(dr,dc);(x,y): (",dr,",",dc,");(",x,",",y,")")
                x,y = x+dr,y+dc
            end
            if isSeat(x,y,input)
                # println("(r,c);(x,y): (",dr,",",dc,");(",x,",",y,")")
                sk[x,y] == 1 ? answer +=1 : nothing
            end
        end
    end
    return answer
end
# input = readlines("2020/data/day_11.txt")
# input = readlines("2020/testdata/day_11.txt")
# input = readlines("2020/testdata/day_11_1.txt")
# sk = zeros(Int8,length(input),length(input[1]))
# skp1 = zeros(Int8,length(input),length(input[1]))
# test2(sk,input)
# println("Sum answer: ",sumVisible(5,5,sk,input))

function seatCustomers2(sk,skp1,input)
    # println("NewStart seatCustomers")
    for r in 1:length(input)
        for c in 1:length(input[1])
            if input[r][c] != '.'
                sumN = sumVisible(r,c,sk,input)
                if r == 9
                    # println("(r,c,sumN): (",r,",",c,",",sumN,")")
                end
                if sk[r,c] == 0 && sumN == 0
                    skp1[r,c] = 1
                elseif sk[r,c] == 1 && sumN >= 5
                    skp1[r,c] = 0
                end
            end
        end
    end
end

function part_2(input)
    sk = zeros(Int8,length(input),length(input[1])); sk[1,1] = 1
    skp1 = zeros(Int8,length(input),length(input[1]))
    while sk != skp1
        sk = copy(skp1)
        seatCustomers2(sk,skp1,input)
    end
    return sum(sum(skp1))
end
@info part_2(input)

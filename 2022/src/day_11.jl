# https://adventofcode.com/2022/day/11

# input = readlines("2022/testdata/day_11.txt")
input = readlines("2022/data/day_11.txt")

function filllist!(mlist, input,mnum)
    for i = 1:mnum
        r = (i-1)*7 + 2 # Row number for Starting Items
        if length(input[r]) >= 19 # There is a number
            mlist[i] = parse.(Int,split(input[r][19:end], ","))
        end
    end
end

function test(mi, val, input)
    num = parse(Int,input[(mi-1)*7+4][22:end])
    return (val % num) == 0
end

function fill_throw(input, mnum)
    tlist = [Dict{Bool,Int}() for i = 1:mnum]
    for i = 1:mnum
        r = (i-1)*7 + 5 # Row number for Starting Items
        tlist[i] = Dict(true => parse(Int,input[r][end])+1, false => parse(Int,input[r+1][end])+1) 
    end
    return tlist
end

function part_1(input)
    mnum = parse(Int, input[end-5][8])+1 # number of monkeys
    mlist = Vector{Int}[ [] for i = 1:mnum]
    mcnt = zeros(Int,mnum)
    filllist!(mlist, input,mnum)
    oplist = [Meta.parse(input[(i-1)*7 + 3][20:end]) for i = 1:mnum ]
    tlist = fill_throw(input, mnum)

    for junk = 1:20
        for i = 1:mnum
            while !isempty(mlist[i])
                global old = popfirst!(mlist[i]) 
                mcnt[i] += 1
                new = eval( oplist[i] ) # Eval only evaluates at the global level - it does not use old in the local scope 
                new = Int(floor(new / 3))
                t = test(i, new, input)
                push!(mlist[tlist[i][t]], new)
            end
        end
    end

    return prod(nlargest(2,mcnt))
end
@info part_1(input)

function part_2(input)
    # divtestdata = prod([23 19 17 13])
    divdata = prod([17 3 19 7 2 5 11 13])
    mnum = parse(Int, input[end-5][8])+1 # number of monkeys
    mlist = Vector{Int}[ [] for i = 1:mnum]
    mcnt = zeros(Int,mnum)
    filllist!(mlist, input,mnum)
    oplist = [Meta.parse(input[(i-1)*7 + 3][20:end]) for i = 1:mnum ]
    tlist = fill_throw(input, mnum)

    for junk = 1:10000
        for i = 1:mnum
            while !isempty(mlist[i])
                global old = popfirst!(mlist[i]) # Eval only evaluates at the global level - it does not use old in the local scope 
                mcnt[i] += 1
                new = eval( oplist[i] ) % divdata # Eval only evaluates at the global level - it does not use old in the local scope 
                # new = Int(floor(new / 3))
                t = test(i, new, input)
                push!(mlist[tlist[i][t]], new)
            end
        end
    end
    @show mlist
    return prod(nlargest(2,mcnt))
end
@info part_2(input)

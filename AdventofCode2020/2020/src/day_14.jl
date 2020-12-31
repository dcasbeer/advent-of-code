# https://adventofcode.com/2020/day/14
using AdventOfCode
using SparseArrays
using Combinatorics

input = readlines("2020/data/day_14.txt")
# input = Array{String,1}(                  ## Test Data
#     ["mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
#     "mem[8] = 11",
#     "mem[7] = 101",
#     "mem[8] = 0"]
# )

function getCurrentInstruction(input,row)
    if input[row][1:3] == "mem"
        i1 = 5
        i2 = findall("]",input[row])[1][1]
        i2 = i2 - 1
        loc = parse(Int64,input[row][i1:i2])
        i1 = findall("=",input[row])[1][1]
        i1 = i1 + 2
        val = parse(Int64,input[row][i1:end])
        return "mem",val,loc
    else
        i1 = findall("=",input[row])[1][1]
        i1 = i1 + 2
        return "mask",reverse(input[row][i1:end]) # My convention is to have lsb on the left
    end
end
dec_bin(x::Int64,l::Int64=36) = digits(x, base=2, pad=l)
bin_dec(x) = parse(Int,reverse(join(string.(x))),base=2) # My convention is to have lsb on the left
function applyBitMask(x::Int64, mask::String)
    xbit = dec_bin(x)
    for i in 1:length(mask)
        if mask[i] == 'X'
            nothing
        else
            xbit[i] = parse(Int64,mask[i])
        end
    end
    return xbit
end
function allocate_memory(input)
    mem_loc = []
    for i in 1:length(input)
        ci = getCurrentInstruction(input,i)
        if ci[1] == "mem"
            mem_loc = push!(mem_loc,ci[3])
        end
    end
    return sparsevec(mem_loc,zeros(Int64,length(mem_loc)))
end

# mask = getCurrentInstruction(input,1)
# val = getCurrentInstruction(input,2)
# @show applyBitMask(val[2],mask[2])

function part_1(input)
    mem = allocate_memory(input)
    mask = ""
    for i in 1:length(input)
        ci = getCurrentInstruction(input,i)
        if ci[1] == "mask"
            mask = ci[2]
        else
            mem[ci[3]] = bin_dec(applyBitMask(ci[2],mask))
        end
    end
    return sum(mem)
end
@info part_1(input)

### -- Part 2 - Bitmask the address location
# input = Array{String,1}(                  ## Test Data
#     ["mask = 000000000000000000000000000000X1001X",
#     "mem[42] = 100",
#     "mask = 00000000000000000000000000000000X0XX",
#     "mem[26] = 1",]
# )
make_feature_space(x::UnitRange{Int64}, n) = Iterators.product(Iterators.repeated(x, n)...)

function createMask(mask,comb,xind)
    # println(mask)
    ans = mask
    for x in zip(xind,comb)
        # println(ans[x[1]])
        ans = replace(ans, "X" => string(x[2]), count=1)
    end
    return ans
end
function applyMemBitMask(x::Int64, tmp_mask::String, mask::String)
    xbit = dec_bin(x)
    for i in 1:length(mask)
        if mask[i] == 'X'
            xbit[i] = parse(Int64,tmp_mask[i])
        elseif tmp_mask[i] == '1'
            xbit[i] = 1
        else
            nothing
        end
    end
    return xbit
end

function part_2(input)
    mem = Dict(0=>0)
    mask = ""
    for i in 1:length(input)
        # @show i, length(mem)
        ci = getCurrentInstruction(input,i)
        if ci[1] == "mask"
            mask = ci[2]
        else
            xind = findall("X",mask)
            for comb in make_feature_space(0:1, length(xind))
                tmp_mask = createMask(mask,comb,xind)
                ind = bin_dec(applyMemBitMask(ci[3],tmp_mask,mask))
                # @show ind
                # @show ci[2]
                # @show tmp_mask
                # @show mask
                # @show dec_bin(ind)
                # @show dec_bin(ci[3])
                # @show comb
                mem[ind] = ci[2]
                # @show mem
            end
        end
    end
    return sum(values(mem))
end
@info part_2(input)

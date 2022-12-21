# https://adventofcode.com/2022/day/5

# input = readlines("2022/testdata/day_5.txt")
input = readlines("2022/data/day_5.txt")

function create_stacks(input)
    sindx = 1:indexin([""], input)[1]-2 # One row above stack index row
    indx = sindx[end]+1 # Stack index row
    h = (sindx[end]) * length(input[sindx]) # Length to create buffers
    num_stacks = parse(Int64, input[indx][end-1])

    # Create a Vector of Vector{Char}
    stacks = [Vector{Char}(undef,0) for _ = 1:num_stacks]

    for r ∈ sindx[end]:-1:1
        for s ∈ 1:num_stacks
            i = (s-1)*4+2
            # @show((r,s,i)
            if input[r][i] ≠ ' '
                push!(stacks[s], input[r][i])
            end
        end
    end
    return stacks
end

function move!(stacks,directions)
    for r ∈ directions
        s = findall(' ', r)
        num = parse(Int64,r[s[1]+1:s[2]-1])
        src = parse(Int64,r[s[3]+1:s[4]-1])
        des = parse(Int64,r[s[5]+1:end])
        # @show(num,src,des)

        for dummy in 1:num
            v = pop!(stacks[src])
            push!(stacks[des], v)
        end
    end
end

function part_1(input)
    stacks = create_stacks(input)
    move!(stacks, input[indexin([""], input)[1]+1:end])
    return String([val[end] for val ∈ stacks])
end
@info part_1(input)

# input = readlines("2022/testdata/day_5.txt")

function move9001!(stacks,directions)
    for r ∈ directions
        s = findall(' ', r)
        num = parse(Int64,r[s[1]+1:s[2]-1])
        src = parse(Int64,r[s[3]+1:s[4]-1])
        des = parse(Int64,r[s[5]+1:end])
        # @show(num,src,des)

        e = length(stacks[src])
        v = splice!(stacks[src],(1:num) .+ (e-num)) 
        append!(stacks[des], v)
    end
end
function part_2(input)
    stacks = create_stacks(input)
    move9001!(stacks, input[indexin([""], input)[1]+1:end])
    return String([val[end] for val ∈ stacks])
end
@info part_2(input)

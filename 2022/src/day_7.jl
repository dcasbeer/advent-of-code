# https://adventofcode.com/2022/day/7

# input = readlines("2022/testdata/day_7.txt")
input = readlines("2022/data/day_7.txt")


function add_dirnode!(mdata, row, current_dir, uidx)
    name = row[5:end]
    mdata[uidx] = ["dir", name, 0, current_dir, Dict()] 
    mdata[current_dir][end][name] =  uidx
end
function add_filenode!(mdata, row, current_dir, uidx)
    space = findfirst(' ', row)
    name = row[space+1:end]
    size = parse(Int,row[begin:space-1])
    mdata[uidx] = ["file", name, size, current_dir, Dict()] 
    mdata[current_dir][end][name] = uidx
end
function create_graph(input)
    mdata = Dict()
    mdata[1] = ["dir", "/", 0, [], Dict()] 
    current_dir = 1
    unique_idx = 1
    for row ∈ input[2:end]
        # @info "Next Row"
        # @show row
        if occursin("..", row)
            # @info "Going up a directory"
            # @show current_dir
            current_dir = mdata[current_dir][4]
            # @show current_dir
            nothing
        elseif occursin("\$ cd", row)
            # @info "Going into directory"
            # @show current_dir
            i = findlast(' ', row) + 1
            current_dir = mdata[current_dir][end][row[i:end]]
            # current_dir = map[row[i:end]]
            # @show current_dir
            nothing
        elseif occursin("\$ ls", row)
            nothing
        elseif occursin("dir", row)
            # @info "Adding a directory"
            unique_idx += 1
            add_dirnode!(mdata, row, current_dir, unique_idx)
            nothing
        else
            # @info "Adding a file"
            unique_idx += 1
            add_filenode!(mdata, row, current_dir, unique_idx)
        end
    end
    return mdata
end

function calc_size!(mdata, cn)
    if mdata[cn][1] == "file"
        return mdata[cn][3]
    end
    size = 0
    for (key,value) ∈ mdata[cn][end]
        size += calc_size!(mdata, value)
    end
    mdata[cn][3] = size
    return mdata[cn][3]
end

function part_1(input)
    mdata = create_graph(input)
    calc_size!(mdata, 1)
    total = 0
    for (key,value) ∈ mdata
        if value[1] == "dir" && value[3] <= 100000
            total += value[3]
        end
    end
    return total, mdata

end
total, mdata = part_1(input)
@info total

function part_2(mdata)
    fs = 70000000
    req = 30000000
    used = mdata[1][3]
    space = fs - used
    need = req - space
    @show need
    best = used
    for (key,value) ∈ mdata
        if (value[3] >= need) && (value[3] < best) && (value[1] == "dir")
            best = value[3]
        end
    end
    return best
end
@info part_2(mdata)

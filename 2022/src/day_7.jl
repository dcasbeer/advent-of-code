# https://adventofcode.com/2022/day/7
using Graphs

input = readlines("2022/testdata/day_7.txt")
# input = readlines("2022/data/day_7.txt")

function add_dirnode!(G,rmap, map, mdata, row, current_node)
    name = row[5:end]
    add_vertex!(G)
    # @show name, nv(G)
    rmap[nv(G)] = name
    map[name] = nv(G)
    mdata[name] = ["dir", name, 0] 
    add_edge!(G, current_node, nv(G))
end

function add_filenode!(G,rmap, map, mdata, row, current_node)
    space = findfirst(' ', row)
    name = row[space+1:end]
    size = parse(Int,row[begin:space-1])
    add_vertex!(G)
    # @show name, nv(G)
    rmap[nv(G)] = name
    map[name] = nv(G)
    mdata[name] = ["file", name, size] 
    add_edge!(G, current_node, nv(G))
end

function calc_size!(mdata, cn, G, map, rmap)
    if mdata[rmap[cn]][1] == "file"
        return mdata[rmap[cn]][3]
    end
    size = 0
    for n = neighbors(G,cn)
        size += calc_size!(mdata, n, G, map, rmap)
    end
    mdata[rmap[cn]][3] = size
    return mdata[rmap[cn]][3]
end

function create_graph(input)
    map = Dict()
    rmap = Dict()
    mdata = Dict()
    G = DiGraph(1)
    map["/"] = 1  # Name to graph index
    rmap[1] = "/" # Graph index to name
    mdata["/"] = ["dir", "/", -1] # Node data: Type(dir or file), Name, and size (default to -1 if not calculated)
    current_node = 1

    for row ∈ input
        # @info "Next Row"
        # @show row
        if occursin("..", row)
            # @info "Going up a directory"
            # @show current_node
            current_node = inneighbors(G, current_node)[1] # only one parent
            # @show current_node
        elseif occursin("\$ cd", row)
            # @info "Going into directory"
            # @show current_node
            i = findlast(' ', row) + 1
            current_node = map[row[i:end]]
            # @show current_node
        elseif occursin("\$ ls", row)
            nothing
        elseif occursin("dir", row)
            # @info "Adding a directory"
            add_dirnode!(G, rmap, map, mdata, row, current_node)
        else
            # @info "Adding a file"
            add_filenode!(G, rmap, map, mdata, row, current_node)
        end
    end
    calc_size!(mdata, 1, G, map, rmap)
    total = 0
    for (key,value) ∈ mdata
        if value[1] == "dir" && value[3] <= 100000
            total += value[3]
        end
    end
    return total, mdata, G, map, rmap
end


total, mdata, G, m, rm = create_graph(input)
@info total

# function part_1(input)
#     nothing
# end
# @info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

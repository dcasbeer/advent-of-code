# https://adventofcode.com/2022/day/12

using Graphs 

# Starts from 'S', which has elevation 'a'
# Ends at 'E' with elevation 'z'

input = readlines("2022/testdata/day_12.txt")
input = readlines("2022/data/day_12.txt")

w = length(input[1])
ind(r,c) = ((r-1) * w) + c


function create_graph(input)
    h = length(input)
    w = length(input[1])
    start = 0
    fin = 0
    G = DiGraph(h*w) # Create Graph of appropriate size
        ## Need to get index of S and E
    for r = 1:h
        tmp = findfirst("S", input[r])
        if tmp != nothing
            start = ind(r,tmp[1])
            input[r] = replace(input[r],"S"=>"a")
        end
        tmp1 = findfirst("E", input[r])
        if tmp1 != nothing
            fin = ind(r,tmp1[1])
            input[r] = replace(input[r],"E"=>"z")
        end
    end

    for r = 1:h, c = 1:w
        for (nrt,nct) = [(-1,0),(1,0),(0,-1),(0,1)]
            (nr,nc) = (r,c).+(nrt,nct)
            # @show "Checking"
            # @show r,c, ind(r,c), nr,nc, ind(nr,nc)
            if (nr)>0 && (nc>0) && (nr<=h) && (nc<=w)
                if input[r][c] + 1 >= input[nr][nc]
                    # @show "Added"
                    # @show r,c, ind(r,c), nr,nc, ind(nr,nc)
                    add_edge!(G, ind(r,c), ind(nr,nc))
                end
            end
        end
    end
    return G,start,fin
end

G,start,fin = create_graph(input)
Ga = bellman_ford_shortest_paths(G,start)
@info "Part1",Ga.dists[fin]

#Part 2 -
function geta(input)
    h = length(input)
    w = length(input[1]) 
    aind = Int[]
    for r = 1:h, c = 1:w
        if input[r][c] == 'a'
            push!(aind,ind(r,c))
        end
    end
    return aind
end

aind = geta(input)
Ga2 = bellman_ford_shortest_paths(G,aind) # Computes the shortest path from a list of nodes (aind) to every other node
@info "Part2",Ga2.dists[fin] # Length of shortest path from any "a node" to the end

# https://adventofcode.com/2022/day/15

using GLMakie
using ColorSchemes
using Distances

function indicator(ax::Axis,ob)
    register_interaction!(ax, :indicator) do event::MouseEvent, axis
    if event.type === MouseEventTypes.over
        ob[] = event.data
    end
    end
end
function indicator(grid::GridLayout,ob)
    foreach(Axis,grid;recursive=true) do ax
    indicator(ax,ob)
    end
end
function indicator(grid::GridLayout)
    ob = Observable(Point2f0(0.,0.))
    indicator(grid,ob)
    ob
end
function indicator(fig,args...; tellwidth=false, kwargs...)
    Label(
        fig,
        lift(ind->"x: $(ind[1])  y: $(ind[2])",indicator(fig.layout)),
        args...; tellwidth=tellwidth, kwargs...
    )
end

input = readlines("2022/testdata/day_15.txt")
input = readlines("2022/data/day_15.txt")

# For this one, there are only 33 total sensor beacon pairs in the data. 
# Don't need to build a map, just write function to check if a point can or cannot contain a beacon
# Only need to check width of farthest beacons


# Command to calculate distance between two points: 
#      cityblock((1,1),(2,10))
# Command to calculate distance between multiple points:
#      cityblock.([[1,1],[4,2],[5,6]],[[2,10]])

function readrow(row)
    x = findall("x=",row)
    y = findall("y=",row)
    c = findall(",",row)
    d = findall(":",row)
    i = x[1][end]+1 : c[1][1]-1
    i2 = y[1][end]+1 : d[1][1]-1
    s = (parse(Int,row[i]),parse(Int,row[i2]))
    i = x[2][end]+1 : c[2][1]-1
    i2 = y[2][end]+1 : length(row)
    b = (parse(Int,row[i]),parse(Int,row[i2]))
    return s,b
end

# First read in sesnor beacon pairs
sbpairs = [copy(Vector{Int}(undef,2)) for i in 1:length(input), j in 1:2]
i = 0
for r ∈ input
    global i += 1
    s,b = readrow(r)
    sbpairs[i,1][1] = s[1]
    sbpairs[i,1][2] = s[2]
    sbpairs[i,2][1] = b[1]
    sbpairs[i,2][2] = b[2]
end

fig = Figure()
ax1 = fig[1,1] = Axis(fig)
for i = 1:size(sbpairs)[1]
    d = cityblock(sbpairs[i,1],sbpairs[i,2])
    S = Point2f0(sbpairs[i,1])
    p1 = S + Point2f0(d,0)
    p2 = S + Point2f0(0,d)
    p3 = S + Point2f0(-d,0)
    p4 = S + Point2f0(0,-d)
    poly!(ax1, [p1, p2, p3, p4], colormap = (:tab20, 0.1), strokecolor = :blue, strokewidth = 1, transparency = true)
end
bnd = 4000000
b1 = Point2f0(0,0)
b2 = Point2f0(0,bnd)
b3 = Point2f0(bnd,bnd)
b4 = Point2f0(bnd,0)
poly!(ax1, [b1, b2, b3, b4], color = (:white, 0), strokecolor = :blue, strokewidth = 2)
txt= fig[2,:] = indicator(fig)
display(fig)

# plot_range_1 = range(0,1;length=1000)
# fig = Figure()
# ax1 = Axis(fig)
# l1 = lines!(ax1,plot_range_1,plot_range_1 .^ 2)
# txt= fig[2,:] = indicator(fig)
# display(fig)

# Found this point by zooming into squares
x = (3316868,2686239)
@info x[1]*4000000 + x[2]
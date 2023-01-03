# https://adventofcode.com/2022/day/15

using Distances # for cityblock distance

input = readlines("2022/testdata/day_15.txt")
# input = readlines("2022/data/day_15.txt")

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
minx = 1000000000
maxx = -1000000000
for r ∈ input
    global i += 1
    global minx
    global maxx
    s,b = readrow(r)
    sbpairs[i,1][1] = s[1]
    sbpairs[i,1][2] = s[2]
    sbpairs[i,2][1] = b[1]
    sbpairs[i,2][2] = b[2]
    if b[1] < minx
        minx = b[1]
    end
    if b[1] > maxx
        maxx = b[1]
    end
end

function binrow(sbpairs,row)
    uq = unique(sbpairs[:,2])
    return sum([thing[2] == row for thing in uq])
end

function part_1(sbpairs, minx, maxx)
    if sbpairs[1,1][1] == 2
        yrow = 10
    else
        yrow = 2000000
        maxx = maxx + 1000000 ## My assumption that it was in convex hull of beacons was incorrent. There is a sensor to the east of the beacon, we need to check farther than that.
    end
    test = [ false for i in minx:maxx]
    for r = 1:size(sbpairs)[1]
        # @show r 
        # @show sbpairs[r,1]
        # @show sbpairs[r,2]
        d = cityblock(sbpairs[r,1],sbpairs[r,2])
        dv = cityblock.([[i,yrow] for i ∈ minx:maxx],[sbpairs[r,1]])
        ### There is a beacon in the row -- need to account for that
        test = test .|| (d .>= dv)
    end
    return sum(test) - binrow(sbpairs,yrow)
end
@info part_1(sbpairs, minx,maxx)



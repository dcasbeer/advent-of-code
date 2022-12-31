# https://adventofcode.com/2022/day/14

input,td = readlines("2022/testdata/day_14.txt"), true
input,td = readlines("2022/data/day_14.txt"), false
# Inspecting the testdatafile the max and min values are
#  Min x: 494
#  Max x: 503
#  Min y: 0
#  Max y: 9
# Inspecting the datafile the max and min values are
#  Min x: 496
#  Max x: 556
#  Min y: 0
#  Max y: 162
if td
    bounds = ((494,503),(0,9))
else
    bounds = ((490,563),(0,162))
end

board = zeros(Int, bounds[1][2]-bounds[1][1]+1, bounds[2][2]-bounds[2][1]+1)
bx(x) = x - bounds[1][1] + 1
by(y) = y + 1
invbx(bx) = bx - 1 + bounds[1][1]
invby(by) = by - 1
boundsm = ( ( bx(bounds[1][1]) , by(bounds[1][2]) ),( bx(bounds[2][1]) , by(bounds[2][2]) ) )

function fill!(board,cpos,epos)
    vjump = 1
    if cpos[1] == -1
        cpos = epos
    end
    if cpos[2] > epos[2]
        vjump = -1
    end
    xjump = 1
    if cpos[1] > epos[1]
        xjump = -1
    end
    # @show cpos,epos,vjump,xjump
    # @show cpos[1]:xjump:epos[1]
    # @show cpos[2]:vjump:epos[2]
    for i = cpos[1]:xjump:epos[1], j = cpos[2]:vjump:epos[2]
        # @show i,j,cpos, epos
        board[bx(i),by(j)] = 1
    end
end

function buildMatrix(board,vec,cpos)
    # @show vec
    if length(vec) > 0
        i1 = findfirst(",", vec)[1]
        x = parse(Int,vec[1:i1-1])
        i2t = findfirst(" ", vec)
        if i2t == nothing
            y = parse(Int,vec[i1+1:end])
            # @show x,y,bx(x),by(y)
            fill!(board,cpos,(x,y))
            return board           
        else
            i2 = i2t[1]
            y = parse(Int,vec[i1+1:i2-1])
            # @show x,y,bx(x),by(y)
            # board[bx(x),by(y)] = 1
            fill!(board,cpos,(x,y))
            # if i2 < length(vec)
            buildMatrix(board,vec[i2+4:end],(x,y))
            # else
            #     return board
            # end
        end
    end
    return board
end
for r ∈ input
    global board
    board = buildMatrix(board,r,(-1,-1))
end

function move(board, (cx,cy))
    # Move the sand one place
    # -- Uses Matrix coordinates
    # @show cx,cy
    if board[cx,cy+1] == 0 # Down
        # @show "Moving down"
        return ( cx , cy+1 )
    end
    if board[cx-1,cy+1] == 0 # Down and left
        # @show "Moving down and left"
        return ( cx-1 , cy+1 )
    end
    if board[cx+1,cy+1] == 0 # Down and right
        # @show "Moving down and right"
        return ( cx+1 , cy+1 )
    end
    # @show "Standing still"
    return (cx,cy) # Can't move
end

function sandDrop!(board)
    # Starts at (500,0)
    # move the sand one step at a time, until it
    #   - Can't move (newpos = current pos)
    #   - It has fallen into abyss (nothing is below it)
    cpos = (bx(500),by(0)) # starting position
    onboard = true
    sand_count = 0
    while onboard
        npos = move( board, cpos )
        # @show npos == cpos
        # @info "Just moved"
        if npos[1] == boundsm[1][1] || npos[1] == boundsm[1][2] || npos[2] == boundsm[2][2]
            # Fell off board
            # @info "Fell off board"
            return sand_count
        elseif npos == cpos 
            # Can't move: put it on board & start a new sand
            # @info "Can't move - edit the board"
            board[cpos[1],cpos[2]] = 2
            cpos = ( bx(500) , by(0) )
            sand_count += 1
        else
            # @info "New position becomes current position"
            cpos = ( npos[1] , npos[2] )
        end
    end
end
@info "Part 1:", sandDrop!(board)

##### Part 2 #############################################
if td
    bounds = [[494,503],[0,9+2]]
else
    bounds = [[490,563],[0,162+2]]
end
h = bounds[2][2] - bounds[2][1]
bounds[1][1] = 500 - h - 2
bounds[1][2] = 500 + h + 2
bx(x) = x - bounds[1][1] + 1
by(y) = y + 1
invbx(bx) = bx - 1 + bounds[1][1]
invby(by) = by - 1
boundsm = ( ( bx(bounds[1][1]) , by(bounds[1][2]) ),( bx(bounds[2][1]) , by(bounds[2][2]) ) )
board = zeros(Int, bounds[1][2]-bounds[1][1]+1, bounds[2][2]-bounds[2][1]+1)
function buildMatrix2(board,vec,cpos)
    # @show vec
    if length(vec) > 0
        i1 = findfirst(",", vec)[1]
        x = parse(Int,vec[1:i1-1])
        i2t = findfirst(" ", vec)
        if i2t == nothing
            y = parse(Int,vec[i1+1:end])
            # @show x,y,bx(x),by(y)
            fill!(board,cpos,(x,y))
            return board           
        else
            i2 = i2t[1]
            y = parse(Int,vec[i1+1:i2-1])
            # @show x,y,bx(x),by(y)
            # board[bx(x),by(y)] = 1
            fill!(board,cpos,(x,y))
            # if i2 < length(vec)
            buildMatrix(board,vec[i2+4:end],(x,y))
            # else
            #     return board
            # end
        end
    end
    return board
end
for r ∈ input
    global board
    board = buildMatrix2(board,r,(-1,-1))
end
board[:,end] .= 1

function sandDrop2!(board)
    # Starts at (500,0)
    # move the sand one step at a time, until it
    #   - Can't move (newpos = current pos)
    #   - It has fallen into abyss (nothing is below it)
    cpos = (bx(500),by(0)) # starting position
    onboard = true
    sand_count = 0
    while onboard
        npos = move( board, cpos )
        # @show npos == cpos
        # @info "Just moved"
        if npos == (bx(500),by(0))
            # Fell off board
            # @info "Fell off board"
            sand_count += 1
            return sand_count
        elseif npos == cpos 
            # Can't move: put it on board & start a new sand
            # @info "Can't move - edit the board"
            board[cpos[1],cpos[2]] = 2
            cpos = ( bx(500) , by(0) )
            sand_count += 1
        else
            # @info "New position becomes current position"
            cpos = ( npos[1] , npos[2] )
        end
    end
end
@info "Part 2:", sandDrop2!(board)

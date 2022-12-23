# https://adventofcode.com/2022/day/9

# input = readlines("2022/testdata/day_9.txt")
# input = readlines("2022/testdata/day_9v2.txt")
input = readlines("2022/data/day_9.txt")

mutable struct State
    x::Int
    y::Int
end
import Base.==  
import Base.=== # Trying to get Set of my State struct to work and not add duplicates ???
h::State == t::State = (h.x == t.x) && (h.y == t.y) 
h::State === t::State = (h.x == t.x) && (h.y == t.y) 

function reldistance(h,t)
    rdis = State(0,0)
    rdis.x = h.x - t.x
    rdis.y = h.y - t.y
    return rdis
end


function move_t!(tstate,rdis)
    # rdis = reldistance(hstate,tstate)
    if abs(rdis.x) <= 1 && abs(rdis.y) <= 1
        return # Don't move if touching
    elseif rdis.y == 0
        if rdis.x < 0
            move!(tstate,'L')
        else
            move!(tstate,'R')
        end
    elseif rdis.x == 0
        if rdis.y < 0
            move!(tstate,'D')
        else
            move!(tstate,'U')
        end
    elseif rdis.x > 0 && rdis.y > 0
        move!(tstate,'U')
        move!(tstate,'R')
    elseif rdis.x > 0 && rdis.y < 0
        move!(tstate,'D')
        move!(tstate,'R')
    elseif rdis.x < 0 && rdis.y < 0
        move!(tstate,'D')
        move!(tstate,'L')
    elseif rdis.x < 0 && rdis.y > 0
        move!(tstate,'U')
        move!(tstate,'L')
    end
end

function move!(state,dir)
    if dir == 'R'
        state.x += 1
    elseif dir == 'U'
        state.y += 1
    elseif dir == 'L'
        state.x -= 1
    elseif dir == 'D'
        state.y -= 1
    end
end

function move_agents!(hstate, tstate, motion,t_hist)
    dir = motion[1]
    dis = parse(Int,motion[3:end])
    for cnt = 1:dis
        move!(hstate,dir)
        move_t!(tstate, reldistance(hstate,tstate))
        push!(t_hist, (tstate.x,tstate.y))
    end
end    

function part_1(input)
    hstate = State(0,0)
    tstate = State(0,0)
    t_hist = Set([(0,0)])
    for row ∈ input
        move_agents!(hstate,tstate,row,t_hist)
        # @show hstate, tstate
    end
    # @show t_hist
    return length(t_hist)
end
@info part_1(input)

function move_string!(state,motion,t_hist)
    dir = motion[1]
    dis = parse(Int,motion[3:end])
    for cnt = 1:dis
        move!(state[1],dir)
        for i = 2:10
            move_t!(state[i], reldistance(state[i-1],state[i]))
        end
        push!(t_hist, (state[10].x,state[10].y))
    end   
    # @show state
end

function part_2(input)
    state = [State(0,0) for i ∈ 1:10]
    t_hist = Set([(0,0)])
    for row ∈ input
        move_string!(state,row,t_hist)
        # @show hstate, tstate
    end
    # @show t_hist
    return length(t_hist)
end
@info part_2(input)

# https://adventofcode.com/2022/day/13

input = readlines("2022/testdata/day_13.txt")
input = readlines("2022/data/day_13.txt")

# Thanks to https://galaxyinferno.com/how-to-solve-advent-of-code-2022-day-13-with-python/
# for the help and suggestions

function compare( v1, v2 )
    # @info "Comparing"
    # @show v1, v2
    while length(v1) > 0 && length(v2) > 0
        # @info "Popping values"
        left = popfirst!(v1)
        right = popfirst!(v2)
        if isa(left, Int) && isa(right, Int) # If both are integers
            # @info "Both are integers"
            # @show left, right
            if left < right
                # @info "Left is smaller"
                return 1 # True - left is smaller
            elseif left > right
                # @info "Right is smaller"
                return 0 # False - left is not smaller
            end
        end
        if isa(left,Array) && isa(right,Int)   # Convert Int to list to compare lists
            # @info "Left is list, right is integer"
            # @show left, right            
            sc = compare(left, [right]) 
            if sc != -1
                return sc
            end
        end
        if isa(left,Int) && isa(right,Array)   # Convert Int to list to compare lists
            # @info "Left is integer, right is list"
            # @show left, right
            sc = compare([left], right) 
            if sc != -1
                return sc
            end
        end
        if isa(left,Array) && isa(right,Array)   # Convert Int to list to compare lists
            # @info "Both are lists"
            # @show left, right
            sc = compare(left, right) 
            if sc != -1
                return sc
            end
        end
    end
    # One (or both) of the lists is (are) empty
    if length(v1) < length(v2) # v1 empty, while v2 is not empty
        return 1 # v1 is shorter
    elseif length(v1) > length(v2) # v2 is empty, while v1 is not empty
        return 0 # v2 is shorter
    else
        return -1 # They are both the same length, here we need to continue the comparison
    end
end
# Test compare function 
# for i = 1:3:22
#     s1 = eval(Meta.parse(input[i]))
#     s2 = eval(Meta.parse(input[i+1]))
#     c = compare( s1, s2 )
#     @info "********* Completed **********"
#     @show i, (i-1)/3+1, c
# end 

function part_1(input)
    sum = 0
    for pair = 1:3:length(input)
        s1 = eval(Meta.parse(input[pair]))
        s2 = eval(Meta.parse(input[pair+1]))
        c = compare(s1,s2)
        # @show pair, Bool(c)
        if Bool(c)
            # @info "Summing"
            # @show sum, pair
            sum += div(pair-1, 3) + 1
            # @show sum
        end
    end
    return sum
end
@info part_1(input)

function part_2(input)
    p1 = 0
    p2 = 0
    # Find d1's position
    for r ∈ input
        # @show r 
        if isempty(r)
            nothing
        else
            # @info "Comparing"
            # @show r, [[2]]
            c1 = compare( eval(Meta.parse(r)), [[2]] )
            if Bool(c1) # If d1 is larger
                p1 += 1
            end
            c2 = compare( eval(Meta.parse(r)), [[6]] )
            if Bool(c2) # If d2 is larger
                p2 += 1
            end
        end
    end
    p1 += 1
    p2 += 2 # Because d1 comes before it
    return p1 * p2
end
@info part_2(input)

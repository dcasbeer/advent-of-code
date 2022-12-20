using DelimitedFiles
using IterTools


function jump(pos,action)
    # Move the position (pos) according to action
    if action[1] == 'R'
        parse(Int,action[2:end])
        pos[1] = pos[1] + parse(Int,action[2:end])
    elseif action[1] == 'U'
        pos[2] = pos[2] + parse(Int,action[2:end])
    elseif action[1] == 'D'
        pos[2] = pos[2] - parse(Int,action[2:end])
    elseif action[1] == 'L'
        pos[1] = pos[1] - parse(Int,action[2:end])
    elseif action == ""
        error("You dummy, this action is empty")
    end
end

function get_path(wire)
    # Take is a list of motions and determine the locations of the turns
    pos = [0;0]
    path = []
    append!(path,vec(pos))
    for idx = 1:length(wire)
        if wire[idx] == ""
            break
        end
        #print("idx = ",idx,", Value: ", wires[1,idx], "\n")
        jump(pos,wire[idx])
        append!(path,vec(pos))
        #print("Position: ",pos,"\n")
    end
    return path
end

function check_intersection(segment1,segment2)
    # Segment 1&2: (Each defined by two x,y coordinates)
    # Determine if they intersect
    #f1(x) = A1*x + b1 = y
    #f2(x) = A2*x + b2 = y
    is_intersection = false
    location = []
    X1 = segment1[1] # Points for segment 1
    Y1 = segment1[2]
    X2 = segment1[3]
    Y2 = segment1[4]
    X3 = segment2[1] # Points for segment 2
    Y3 = segment2[2]
    X4 = segment2[3]
    Y4 = segment2[4]

    #@show X1, Y1
    if X1 == X2 # Segment 1 is vertical
        if (Y3 == Y4 && Y3 < max(Y1,Y2) && Y3 > min(Y1,Y2) # Segment 2 is horizontal
            && max(X3,X4) > X1 && min(X3,X4) < X1)
            return (true,[X1,Y3])
        end # If these aren't true, then it doesn't intersect
    else # Segment 1 is horizontal
        if (X3 == X4 && X3 < max(X1,X2) && X3 > min(X1,X2) # Segment 2 is vertical
            && max(Y3,Y4) > Y1 && min(Y3,Y4) < Y1)
            return (true,[X3,Y1])
        end
    end
    return (is_intersection,location)
end

function find_closest_intersection(path1, path2)
    # Closest Mahattan Distance
    closest_intersection = []
    distance = Inf
    for idx in Iterators.product(1:2:length(path1)-2, 1:2:length(path2)-2)
        answer = check_intersection(path1[idx[1]:idx[1]+3],path2[idx[2]:idx[2]+3])
        if answer[1]
            # print("Intersection location: ",answer[2]," Distance = ",sum(abs.(answer[2])),"\n")
            if sum(abs.(answer[2])) < distance
                closest_intersection = answer[2]
                distance = sum(abs.(answer[2]))
            end
        end
    end
    return (closest_intersection, distance)
end

function get_length(path_segment)
    return sum(abs.(path_segment[1:2]-path_segment[3:4]))
end

function find_shortest_sumpath(path1, path2)
    # Intersection with the smallest sum of path lengths from central port
    closest_intersection = []
    distance = Inf
    length1 = 0
    for idx1 = 1:2:length(path1)-2
        length2 = 0
        for idx2 = 1:2:length(path2)-2
            answer = check_intersection(path1[idx1:idx1+3],path2[idx2:idx2+3])
            #@show length1,length2
            if answer[1]
                # print("Intersection location: ",answer[2]," Distance = ",sum(abs.(answer[2])),"\n")
                #@show path1[idx1:idx1+1],answer[2]
                l1 = get_length([path1[idx1:idx1+1];answer[2]])
                l2 = get_length([path2[idx2:idx2+1];answer[2]])
                #@show l1,l2,answer[2]
                if length1+l1 + length2+l2 < distance
                    closest_intersection = answer[2]
                    distance = length1+l1 + length2+l2
                end
            end
            # Add path length for current segment on path 2
            length2 = length2 + get_length(path2[idx2:idx2+3])
        end
        # Add path length for current segment on path 1
        length1 = length1 + get_length(path1[idx1:idx1+3])
    end
    return (closest_intersection, distance)
end

#--- Test jump
# pos = [0,0]
# print("Position: ",pos,"\n")
# jump(pos,"D2")
# print("Position: ",pos,"\n")
# jump(pos,"L34")
# print("Position: ",pos,"\n")

#--- read in the input
#wires = readdlm(joinpath(@__DIR__, "day3_testinput0.csv"), ',')
#wires = readdlm(joinpath(@__DIR__, "day3_testinput1.csv"), ',')
#wires = readdlm(joinpath(@__DIR__, "day3_testinput2.csv"), ',')
wires = readdlm(joinpath(@__DIR__, "day3_input.csv"), ',')
w,l = size(wires)

# #--- Move the wire
# pos = [0;0]
# for idx = 1:l
#     if wires[1,idx] == ""
#         error("You dummy, this action is empty")
#     end
#     #print("idx = ",idx,", Value: ", wires[1,idx], "\n")
#     jump(pos,wires[1,idx])
#     #print("Position: ",pos,"\n")
# end
# # for idx in Iterators.product(1:w,1:l)
# #
# # end
# # **** This finds the end location of the path - not what they want

#--- Determine the path
path1 = get_path(wires[1,:])
path2 = get_path(wires[2,:])

#--- Find the intersections
# for idx in Iterators.product(1:2:length(path1)-2, 1:2:length(path2)-2)
#     answer = check_intersection(path1[idx[1]:idx[1]+3],path2[idx[2]:idx[2]+3])
#     if answer[1]
#         print("Intersection location: ",answer[2]," Distance = ",sum(abs.(answer[2])),"\n")
#     end
# end

print("\nAnswer for Day 3 Problem 1: \n")
@show find_closest_intersection(path1,path2)


#--- Day3 Problem 2
print("\nAnswer for Day 3 Problem 2: \n")
@show find_shortest_sumpath(path1, path2)

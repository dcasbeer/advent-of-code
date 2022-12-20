# https://adventofcode.com/2022/day/1

# input = readlines("2022/testdata/day_1.txt")    
input = readlines("2022/data/day_1.txt")

function part_1(input)
    blank = findall(x->x=="",input)
    #blank = push!(blank, length(input)+1)
    num_elves = length(blank) + 1
    max_calorie = 0
    which_elf = 0
    for ind in 1:num_elves
        if ind == 1  
            f = 1
            l = blank[ind]-1
        elseif ind == num_elves
            f = blank[ind-1] + 1
            l = length(input)
        else
            f = blank[ind-1] + 1
            l = blank[ind] - 1
        end
        #@show(ind,f,l)
        s = sum(parse.(Int, input[f:l]))
        # @show(s)
        if s > max_calorie  
            max_calorie = s
            which_elf = ind
        end
        # nothing
    end
    return max_calorie
end

@info part_1(input)

function part_2(input)
    blank = findall(x->x=="",input)
    #blank = push!(blank, length(input)+1)
    num_elves = length(blank) + 1
    max_3_calorie = zeros(Int,3)
    which_elf = 0
    for ind in 1:num_elves
        if ind == 1  
            f = 1
            l = blank[ind]-1
        elseif ind == num_elves
            f = blank[ind-1] + 1
            l = length(input)
        else
            f = blank[ind-1] + 1
            l = blank[ind] - 1
        end
        #@show(ind,f,l)
        s = sum(parse.(Int, input[f:l]))
        # @show(s)
        if s > minimum(max_3_calorie)  
            v,i = findmin(max_3_calorie)
            #@show(i,v)
            max_3_calorie[i] = s
            #@show(max_3_calorie)
        end
        # nothing
    end
    return sum(max_3_calorie)
end
@info part_2(input)

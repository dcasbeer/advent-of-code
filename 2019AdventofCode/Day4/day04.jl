#range = 1:10
range = 138307:654504

# To get the individual digits from an integer number
# julia> digits(a,base=10)
# 6-element Array{Int64,1}:
#  8
#  3
#  9
#  3
#  2
#  1

function is_repeat(na)
    if (na[6] == na[5]
        || na[5] == na[4]
        || na[4] == na[3]
        || na[3] == na[2]
        || na[2] == na[1])
        return true
    else
        return false
    end
end

function is_nondecreasing(na)
    if (na[6] <= na[5]
        && na[5] <= na[4]
        && na[4] <= na[3]
        && na[3] <= na[2]
        && na[2] <= na[1])
        return true
    else
        return false
    end
end

function is_valid_password(na)
    return is_repeat(na) && is_nondecreasing(na)# && count_repeats(na)
end

## Problem 1
# # Test
# a = 111111
# b = 223450
# c = 123789
# d = 122345
# num = d
# @show is_repeat(digits(num,base=10)), is_nondecreasing(digits(num,base=10))

count = 0
for number in range
    #print(number)
    num_array = digits(number,base=10)
    # if is_repeat(num_array) && is_nondecreasing(num_array)
    #     global count += 1
    # end
    if is_valid_password(num_array)
        global count += 1
    end
end
# Problem 1
#@show count
print("----------------------------------------\n")
print("Answer to problem 1\n")
print("There are ", count," possible passwords.\n\n")


## Problem 2 -----------------------
function count_repeats(na)
    count = 1
    # @show na
    for ind = length(na):-1:2
        if na[ind] == na[ind-1]
            count += 1
            # print("They are the same -- ")
            # @show na[ind],na[ind-1],ind,count
        else
            if count == 2
                # print("There is a repeat pair")
                # @show na[ind],na[ind-1],ind,count
                return true
            end
            count = 1
            # print("Reset Count")
            # @show na[ind],na[ind-1],ind,count
        end
    end
    if count == 2
        return true
    else
        # print("Odd count returning false \n")
        return false
    end
    return true
end

function is_valid_password2(na)
    return is_nondecreasing(na) && count_repeats(na)
end

# # Test
# a = 112233
# b = 123444
# c = 111122
# d = 122223
# num = digits(d,base=10)
# @show is_repeat(num), is_nondecreasing(num), count_repeats(num)
# #@show is_valid_password2(num)

count = 0
for number in range
    #print(number)
    num_array = digits(number,base=10)
    # if is_repeat(num_array) && is_nondecreasing(num_array)
    #     global count += 1
    # end
    if is_valid_password2(num_array)
        global count += 1
    end
end
# Problem 2
print("Answer to problem 2\n")
print("There are ", count," possible passwords.\n\n")
#@show count

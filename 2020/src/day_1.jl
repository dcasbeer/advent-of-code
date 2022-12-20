# https://adventofcode.com/2020/day/1
using AdventOfCode

# input = readlines("2020/data/day_1.txt")
# input = parse.(Int64,readlines("2020/testdata/day_1.txt"))
input = parse.(Int64,readlines("2020/data/day_1.txt"))

function part_1(input)
   len = length(input)
   for c1 in 1:len, c2 in c1+1:len # Need to do double loop so that I can break out
      if input[c1] + input[c2] == 2020
         # print("The answer for Day 1 Puzzle 1: ", input[c1] * input[c2], "\n")
         return input[c1] * input[c2]
      end
   end
   # print("xval1 = ", x1, "\n")
   # print("xval2 = ", x2, "\n")
   # answer = x1 * x2
end
@info part_1(input)

function part_2(x)
   len = length(x)
   for c1 in 1:len, c2 in c1+1:len, c3 in c2+1:len
      # print(c1, ",",c2, ",",c3, "\n")
      # print("x1 = ", x[c1], ", x2 = ", x[c2], ", x3 = ", x[c3], "\n")
      # print(x[c1] + x[c2] + x[c3], "\n")
      if x[c1] + x[c2] + x[c3] == 2020
         # print("I got the answer") #### ????? For some reason I had to include this to get it to print
         # print("The answer for Day 1 Puzzle 2: ")
         # print(x[c1] * x[c2] * x[c3])
         return x[c1] * x[c2] * x[c3]
      end
   end
end
@info part_2(input)

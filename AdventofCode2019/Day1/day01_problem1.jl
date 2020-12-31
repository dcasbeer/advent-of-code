using DelimitedFiles

#--- Day 01 Problem 1

input_file = "day01_input.txt"
input_file_fullpath = string(@__DIR__, "/", input_file)
#print(input_file_fullpath, "\n\n")

# open(input_file_fullpath, "r") do f   # "r" for reading
#   filecontent = read(f,String) # attention that it can be used only once. The second time, without reopening the file, read() would return an empty string
#   print(filecontent)
# end # Do block closes file automatically when complete

x = readdlm(input_file_fullpath, '\t', Int, '\n')

answer = sum(Int.(floor.(x/3)).-2)

print("\n\n--------------------\n")
print("Here is the answer for Day 1 Puzzle 1: ", answer)
print("\n")

# Testing write output to a file
# output_file = "day01_output.txt"
# output_file_fullpath = string(@__DIR__, "/", output_file)
# open(output_file_fullpath, "w") do io
#      writedlm(io, answer)
# end

#--- Day 01 Problem 2

# # *** Doing this for one module
#initial_mass = 1969
#initial_mass = 100756
initial_mass = 1026 # Test a few modules from the input data
fuel = Int(floor((initial_mass)/3)) - 2#answer
total_fuel = 0
while fuel > 0
   global total_fuel
   global fuel
   print(fuel,"\n")
   total_fuel += fuel
   fuel = Int(floor((fuel)/3)) - 2
end
print(total_fuel,"\n")
# # *** It is correct

# *** Now do this for the array

initial_mass = x
fuel = Int.(floor.(x/3)).-2
module_done = fuel .>= 0


total_fuel = zeros(Int, size(initial_mass))
while sum(module_done) > 0
   global total_fuel
   global fuel
   global module_done
   total_fuel += module_done.*fuel
   fuel = module_done.*Int.(floor.(fuel/3)).-2
   module_done = fuel .>= 0
end
#print(total_fuel)
print(sum(total_fuel))
print("\n--------------------")

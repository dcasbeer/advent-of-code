##---
using DelimitedFiles
#using IterTools

##--- Helper Functions

function pm(parameter,mode,vecx)
	#@show parameter, mode, vecx
	if mode == 0 # position mode
		return vecx[parameter+1] # Remember julia using 1 indexing
	elseif mode == 1 # immediate mode
		return parameter
	end
end

function pmIdx(param_pos,mode,vecx)
	if mode == 0 # position mode
		return vecx[param_pos]+1 # Remember julia using 1 indexing
	elseif mode == 1 # immediate mode
		return param_pos
	end
end

function digits2integer(a)
     x = reduce(string, reverse(a))
     if length(a)==1
         return x
     end
	 parse(Int, x)
end

function get_opcode(opcode)
	if length(opcode) == 1
		return opcode[1]
	else
		return digits2integer(opcode[1:2])
	end
end

function getmode(opcode,pos)
	if length(opcode) < pos
		return 0
	else
		return opcode[pos]
	end
end

function opcode_add(vecx,pos,opcode)
	#global vecx
	#print("Add values from pos: ", pos, '\n')
	value1 = pm(vecx[pos+1],getmode(opcode,3),vecx)
	value2 = pm(vecx[pos+2],getmode(opcode,4),vecx)
	idx3 = pmIdx(pos+3,getmode(opcode,5),vecx)
	vecx[idx3] = value1 + value2
	#print(idx3)
	return pos = pos + 4
end


function opcode_multiply(vecx,pos,opcode)
	#global vecx
	#print("Add values from pos: ", pos, '\n')
	value1 = pm(vecx[pos+1],getmode(opcode,3),vecx)
	value2 = pm(vecx[pos+2],getmode(opcode,4),vecx)
	idx3 = pmIdx(pos+3,getmode(opcode,5),vecx)
	vecx[idx3] = value1 * value2
	#print(idx3)
	return pos = pos + 4
end



function opcode3(vecx,pos,input)
	# Parameters that an instruction writes to will never be in immediate mode.
	# Thus this opcode is always in parameter mode 0 (position mode)
	idx = vecx[pos+1] + 1 # Remember julia using 1 indexing
	vecx[idx] = input
	return pos = pos + 2
end

function opcode4(vecx,pos,opcode)
	idx = pos+1 # Remember julia using 1 indexing
	# Output the value
	parameter = vecx[idx]
	value = pm(parameter, getmode(opcode,3), vecx)
	#@show vecx, pos, opcode, value
	print("Output value: ", value,"\n")
	return pos = pos + 2
end

function opcode5(vecx,pos,opcode) # jump-if-true
	#global vecx
	#print("Add values from pos: ", pos, '\n')
	param1 = pm(vecx[pos+1],getmode(opcode,3),vecx)
	if param1 != 0
		param2 = pm(vecx[pos+2],getmode(opcode,4),vecx)
		return param2+1
	end
	return pos = pos+3
end

function opcode6(vecx,pos,opcode) # jump-if-false
	#global vecx
	#print("Add values from pos: ", pos, '\n')
	#@show vecx
	#@show pos, opcode
	param1 = pm(vecx[pos+1],getmode(opcode,3),vecx)
	#@show param1
	if param1 == 0
		param2 = pm(vecx[pos+2],getmode(opcode,4),vecx)
		#@show param1, param2
		return param2+1
	end
	return pos+3
end

function opcode7(vecx,pos,opcode) # jump-if-true
	#global vecx
	#print("Add values from pos: ", pos, '\n')
	param1 = pm(vecx[pos+1],getmode(opcode,3),vecx)
	param2 = pm(vecx[pos+2],getmode(opcode,4),vecx)
	idx3 = pmIdx(pos+3,getmode(opcode,5),vecx)
	if param1 < param2
		vecx[idx3] = 1
	else
		vecx[idx3] = 0
	end
	return pos = pos + 4
end

function opcode8(vecx,pos,opcode) # jump-if-true
	#global vecx
	#print("Add values from pos: ", pos, '\n')
	param1 = pm(vecx[pos+1],getmode(opcode,3),vecx)
	param2 = pm(vecx[pos+2],getmode(opcode,4),vecx)
	idx3 = pmIdx(pos+3,getmode(opcode,5),vecx)
	if param1 == param2
		vecx[idx3] = 1
	else
		vecx[idx3] = 0
	end
	return pos = pos + 4
end


# function askname()
# 	### Does not work in Atom *****
#     print("Enter your name: ")
#     a = chomp(readline(stdin))
# 	print(a,"\n")
# end
# ## Test the code
# askname()

function Intcode_computer(vecx,input)
	pos = 1
	opcode = digits(vecx[pos],base=10)
	#@show opcode, get_opcode(opcode)
	while get_opcode(opcode) != 99 #vecx[pos] != 99
		#global pos
		#print("Position in while loop: ", pos, '\n')
		if get_opcode(opcode) == 1
			pos = opcode_add(vecx,pos,opcode)
		elseif get_opcode(opcode) == 2
			pos = opcode_multiply(vecx,pos,opcode)
		elseif get_opcode(opcode) == 3
			pos = opcode3(vecx,pos,input)
		elseif get_opcode(opcode) == 4
			pos = opcode4(vecx,pos,opcode)
		elseif get_opcode(opcode) == 5
			pos = opcode5(vecx,pos,opcode)
		elseif get_opcode(opcode) == 6
			pos = opcode6(vecx,pos,opcode)
		elseif get_opcode(opcode) == 7
			pos = opcode7(vecx,pos,opcode)
		elseif get_opcode(opcode) == 8
			pos = opcode8(vecx,pos,opcode)
		else
			error("Opcode Undefined: ", vecx[pos], " At position: ", pos)
		end
		opcode = digits(vecx[pos],base=10)
		#@show opcode, get_opcode(opcode)
	end
	#return vecx
end


# ## Test
# vecx = [3,0,4,0,99] # Test case 1
# input = 4
# print("Begin Intcode: vecx = ", vecx, "\n")
# #@show vecx
# Intcode_computer(vecx,input) # Functions that change array arguments change original array
# print("Intcode Completed \n")
# @show vecx


##--- Read in the data
x = vec(readdlm(joinpath(@__DIR__, "day05_input.csv"), ',', Int))
vecx = deepcopy(x) # Julia for = doesn't copy is makes a reference *** CRAZY

#--- Run the program - Solving Problem 1
print("Solving Problem 1 ********* \n")
input = 1
Intcode_computer(vecx,input) # Functions that change array arguments change original array

## Test Problem 2
# print("\n\n\n\nTesting Problem 2 ********* \n")
# #****** Test 1
# vecx = [3,9,8,9,10,9,4,9,99,-1,8]
# @show vecx
# input = 9
# Intcode_computer(vecx,input) # Functions that change array arguments change original array
# #****** Test 2
# vecx = [3,9,7,9,10,9,4,9,99,-1,8]
# @show vecx
# input = 30
# Intcode_computer(vecx,input) # Functions that change array arguments change original array
# #****** Test 3
# vecx = [3,3,1108,-1,8,3,4,3,99]
# @show vecx
# input = 8
# Intcode_computer(vecx,input) # Functions that change array arguments change original array
# #****** Test 4
# vecx = [3,3,1107,-1,8,3,4,3,99]
# @show vecx
# input = 3
# Intcode_computer(vecx,input) # Functions that change array arguments change original array
# #****** Test 5
# vecx = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
# @show vecx
# input = -20
# Intcode_computer(vecx,input) # Functions that change array arguments change original array
# #****** Test 6
# vecx = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
# @show vecx
# input = 0
# Intcode_computer(vecx,input) # Functions that change array arguments change original array
# #****** Test 7
# vecx = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]
# @show vecx
# input = 9
# Intcode_computer(vecx,input) # Functions that change array arguments change original array

##--- Read in the data
x = vec(readdlm(joinpath(@__DIR__, "day05_input.csv"), ',', Int))
vecx = deepcopy(x) # Julia for = doesn't copy is makes a reference *** CRAZY

#--- Run the program - Solving Problem 1
print("Solving Problem 2 ********* \n")
input = 5
Intcode_computer(vecx,input) # Functions that change array arguments change original array

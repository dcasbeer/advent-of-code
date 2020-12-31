#---
using DelimitedFiles
using IterTools

#--- Helper Functions

function opcode_add(vecx,pos)
        #global vecx
        #print("Add values from pos: ", pos, '\n')
        idx1 = vecx[pos+1] + 1 # Remember julia using 1 indexing
        idx2 = vecx[pos+2] + 1 # Input data is 0 indexed
        idx3 = vecx[pos+3] + 1
        vecx[idx3] = vecx[idx1] + vecx[idx2]
        #print(idx3)
        return pos = pos + 4
end

function opcode_multiply(vecx,pos)
        #global vecx
        #print("Add values from pos: ", pos, '\n')
        idx1 = vecx[pos+1] + 1 # Remember julia using 1 indexing
        idx2 = vecx[pos+2] + 1 # Input data is 0 indexed
        idx3 = vecx[pos+3] + 1
        vecx[idx3] = vecx[idx1] * vecx[idx2]
        #print(idx3)
        return pos = pos + 4
end

function Intcode_computer(vecx)
        pos = 1
        while vecx[pos] != 99
                #global pos
                #print("Position in while loop: ", pos, '\n')
                if vecx[pos] == 1
                        pos = opcode_add(vecx,pos)
                elseif vecx[pos] == 2
                        pos = opcode_multiply(vecx,pos)
                else
                        error("Opcode Undefined: ", vecx[pos], " At position: ", pos)
                end
        end
        #return vecx
end

#--- Read in the data
x = vec(readdlm(joinpath(@__DIR__, "day02_input.csv"), ',', Int))
vecx = deepcopy(x) # Julia for = doesn't copy is makes a reference *** CRAZY

# Modify two values
vecx[2] = 12
vecx[3] = 2

#vecx = [1;0;0;0;99] # Test case 1
#vecx = [2;3;0;3;99] # Test case 2
#vecx = [2,4,4,5,99,0] # Test case 3
#vecx = [1,1,1,4,99,5,6,0,99] # Test case 4


#--- Run the program - Solving Problem 1
print("Solving Problem 1 ********* \n")
Intcode_computer(vecx) # Functions that change array arguments change original array

print("Value in position 0: ", vecx[1], "\n")

#--- Test iterators
# for idx in Iterators.product(0:10,11:15)
#         print("Index: ",idx,"\n")
# end

#--- Run the program - Solving Problem 2
print("Solving Problem 2 ********* \n")
vecx = deepcopy(x)
vecx[2] = 12
vecx[3] = 2
Intcode_computer(vecx)
answer = 0

noun = 2
verb = 3
for idx in Iterators.product(0:99,0:99)
        vecx = deepcopy(x)
        vecx[noun] = idx[1]
        vecx[verb] = idx[2]
        Intcode_computer(vecx)
        #print("Index: ",idx,"  Answer: ", vecx[1])
        if vecx[1] == 19690720
                print("Index: ",idx,"  Output: ", vecx[1],'\n')
                global answer = idx
                break
        end
end

print("The answer is: ",100*answer[1] + answer[2])

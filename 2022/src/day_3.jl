# https://adventofcode.com/2022/day/3

# input = readlines("2022/testdata/day_3.txt")
input = readlines("2022/data/day_3.txt")

charmap = append!(collect('a':'z'), collect('A':'Z'))
d = Dict( charmap[i] => i for i ∈ 1:length(charmap))

function part_1(input)
    psum = 0
    for line ∈ input 
        len = Int64(length(line)/2)
        i1 = line[begin:len]
        i2 = line[len+1:end]
        val = intersect(i1,i2)[1]
        # @show(val)
        psum += d[val]
    end
    return psum
end
@info part_1(input)

function part_2(input)
    psum = 0
    for i = 1:3:length(input)
        val = intersect( intersect(input[i], input[i+1]), input[i+2])[1]
        psum += d[val]
    end
    return psum
end
@info part_2(input)

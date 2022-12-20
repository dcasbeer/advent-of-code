# https://adventofcode.com/2020/day/13
using AdventOfCode

input = readlines("2020/data/day_13.txt")
# input = readlines("2020/testdata/day_13.txt")

eta = parse(Int64,input[1])
function getBuses(input)
    buses = split(input[2],',')
    ans = Array{Int64,1}()
    for b in buses
        if b != "x" 
            push!(ans,parse(Int64,b))
        end
    end
    return ans
end
function getFeasibleTime(eta,b)
    for i = eta:eta+b
        if rem(i,b) == 0
            return i
        end
    end
end
function getBus(eta,buses)
    min = Inf
    minb = 0
    for b in buses
        a = getFeasibleTime(eta,b)
        if a < min
            min = a
            minb = b
        end
    end
    return (min,minb)
end

function part_1(eta,input)
    ans = getBus(eta,getBuses(input))
    return (ans[1]-eta)*ans[2]
end
@info part_1(eta,input)
# input = readlines("2020/testdata/day_13.txt") # 1068788
test1 = "17,x,13,19" # 3417
test1 = "67,7,59,61" # 754018
test1 = "67,x,7,59,61" # 779210
test1 = "67,7,x,59,61" # 1261476
test1 = "1789,37,47,1889" # 1202161486


function gcd2(b,m)
    if m > b
         rkm1 = m
         rk = b
    else
        rkm1 = b
        rk = m
    end
    rkp1 = 1 # Initialize to start while loop
    while rkp1 != 0
        q = rkm1 ÷ rk 
        rkp1 = rkm1 - q*rk # Get remainder
        println("Quotient: ",q," r{k-1} = ",rkm1," r{k} = ",rk," r{k+1} = ",rkp1)
        rkm1 = rk # Update values for next iteration
        rk = rkp1
        println("r{k-1} = ",rkm1," r{k} = ",rk," r{k+1} = ",rkp1)
    end
    return rkm1
end
function bezout(b,m)
if m > b
        rkm1 = m
        rk = b
    else
        rkm1 = b
        rk = m
    end
    skm1,tkm1,sk,tk = 1,0,0,1
    rkp1 = 1 # Initialize to start while loop
    while rkp1 != 0
        tempk = rkp1
        tempkm1 = rk
        q = rk ÷ rkp1 
        rkp1 = rkm1 - q*rk
        skp1 = skm1 - q*sk
        tkp1 = tkm1 - q*tk
        rk = tempk
        rkm1 = tempkm1
    end
    return rk
end
println(gcd2(240,46))

function part_2(input)
    nothing
end
@info part_2(input)

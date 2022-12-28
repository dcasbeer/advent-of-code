old = 59304828292


# Operations
# old * 19
# old + 6
# old * old
# old + 3
# Divisible by test
# 23, 19, 17, 13
div = [23 19 17 13]

@info [old % d for d in div]
@info [(old * 19) % d for d in div]
@info [(old + 6) % d for d in div]
@info [(old * old) % d for d in div] ## Not sure what is going on here
@info [(old + 3) % d for d in div]
@show "-----"
p = prod(div)

@info [((old % p) * 19) % d for d in div]
@info [((old % p) + 6 ) % d for d in div]
@info [((old % p) * old) % d for d in div]
@info [((old % p) + 3) % d for d in div]
# @info ((old * 19) % p)
# @info ((old + 6) % p)
# @info ((old * old) % p)
# @info ((old + 3) % p)

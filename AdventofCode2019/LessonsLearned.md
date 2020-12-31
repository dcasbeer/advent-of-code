# Day 1

## Namespace
*while* and *for* loops have their own namespace. Thus the variable *x*, defined in the "outer" scope is not known to the while loop.

      julia> x = 0
      0

      julia> while x < 10
                 x += 1
                 print("x = ", x)
             end
      ERROR: UndefVarError: x not defined
      Stacktrace:
       [1] top-level scope at ./none:2

**Solution** Tell the while loop to use the outside value *x*

        julia> x = 0
        0

        julia> while x < 10
                   global x
                   x += 1
                   print("x = ", x ,"\n")
               end
        x = 1
        x = 2
        x = 3
        x = 4
        x = 5
        x = 6
        x = 7
        x = 8
        x = 9
        x = 10

## Array's
Need to vectorize functions and operators. This can be done easily by adding a '.' *e.g.*,

      julia> a = vec(0:10)
      0:10

      julia> a + 2
      ERROR: MethodError: no method matching +(::UnitRange{Int64}, ::Int64)
      Closest candidates are:
        +(::Any, ::Any, ::Any, ::Any...) at operators.jl:529
        +(::Complex{Bool}, ::Real) at complex.jl:297
        +(::Missing, ::Number) at missing.jl:115
        ...
      Stacktrace:
       [1] top-level scope at none:0

      julia> a .+ 2
      2:12

# Day 2
* 'a = b' where b is some array *Does not copy b*
  * '=' binds 'a' to the value of 'b'
  * Changing 'a' changes the value in 'b' (See below)

        julia> b = [20]
        1-element Array{Int64,1}:
         20

        julia> a = b
        1-element Array{Int64,1}:
         20

        julia> a[1] = 30
        30

        julia> b
        1-element Array{Int64,1}:
         30

* Occurance: I read in the input file into a variable x
  * I copied that value x into vecx for processing
  * This changes the original value of x
  * I went to reinitialize vecx with the supposed original value 'x', and I was getting vecx
* *Fix:* Use deepcopy (or copy) - vecx = deepcopy(x)
* Also, I threw an error if the Intcode_computer does not know what to do

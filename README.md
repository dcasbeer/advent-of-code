# AdventOfCode.jl

[![Build Status](https://travis-ci.com/SebRollen/AdventOfCode.jl.svg?branch=master)](https://travis-ci.com/SebRollen/AdventOfCode.jl)
[![codecov](https://codecov.io/gh/SebRollen/AdventOfCode.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/SebRollen/AdventOfCode.jl)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://SebRollen.github.io/AdventOfCode.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://SebRollen.github.io/AdventOfCode.jl/dev)  

Helper library for working with Advent of Code in Julia.

This file will download the data for the day and create a script to start solviing the day's riddle.

For my setup: 
* Activate the local environment
    * From the current directory (AdventOfCode)
    * `(@v1.6) pkg> activate .`
    * Now I'm in `(AdventOfCode) pkg>`
* Load the AdventOfCode package
    * import AdventOfCode
* Run to download the data
    * For current day
        * `julia> AdventOfCode.setup_files()` 
        * I had to run this twice. It throws an error the first time???
    * For a specific day
        * `julia> AdventOfCode.setup_files(year, day)`
        * Where year is a four number format, and day is the day of the month.

I use `Advent of Code to Markdown` Chrome extension to download the instructions (can I automate this?)
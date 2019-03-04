# Wanderer

[![Latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://thautwarm.github.io/Wanderer.jl/latest)

[![Build Status](https://travis-ci.com/thautwarm/Wanderer.jl.svg?branch=master)](https://travis-ci.com/thautwarm/Wanderer.jl)
[![Codecov](https://codecov.io/gh/thautwarm/Wanderer.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/thautwarm/Wanderer.jl)
[![Coveralls](https://coveralls.io/repos/github/thautwarm/Wanderer.jl/badge.svg?branch=master)](https://coveralls.io/github/thautwarm/Wanderer.jl?branch=master)

```julia
using Wanderer

DataSource = Dict(
    :a => [1, 2, 3, 4],
    :b => [2, 3, 4, 6],
    :c => [3, 4, 5, 6]
)

df = DataSource |>
       @select _, _.a + _.b + _.c => "a + b + c",
       @where _."a + b + c" !== missing,
       @groupby _."a + b + c" / _.a => key,
       @having key != 4.5,
       @orderby _.a |> length,
       @select sum.(_."a + b + c") => sum, _.key => key
```
outputs:
```julia
Dict{Symbol,Array{T,1} where T} with 2 entries:
  :key => [6.0, 4.0]
  :sum => Array{Int64,1}[[6], [12, 16]]
```
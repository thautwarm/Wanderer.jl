using Documenter, Wanderer

makedocs(;
    modules=[Wanderer],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/thautwarm/Wanderer.jl/blob/{commit}{path}#L{line}",
    sitename="Wanderer.jl",
    authors="thautwarm",
    assets=[],
)

deploydocs(;
    repo="github.com/thautwarm/Wanderer.jl",
)

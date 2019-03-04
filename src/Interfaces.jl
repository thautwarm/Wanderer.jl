export get_fields, get_records, build_result

function get_fields
end

function get_records
end

function build_result
end

try
    # interface for `DataFrame`s
    get_fields(df :: DataFrame) = names(df)
    get_records(df :: DataFrame) = zip(DataFrames.columns(df)...)
    function build_result(::Type{DataFrame}, fields, typs, source :: Union{Base.Generator, Vector{Tp}}) where Tp <: Tuple
        res = Tuple(typ[] for typ in typs)
        for each in source
            push!.(res, each)
        end
        DataFrame(collect(res), fields)
    end
catch
    @warn """
    DataFrames.jl not installed. If you want to peform queries on DataFrames with Wanderer.jl,
    build Wanderer.jl once again after installed DataFrames.jl.
    """
end

# interface for `Dict`s
get_fields(df :: D) where D <: Dict{Symbol} = collect(keys(df))
get_records(df :: D) where D <: Dict{Symbol} = zip((df[key] for key in keys(df))...)
function build_result(::Type{D}, fields, typs, source :: Union{Base.Generator, Vector{Tp}}) where {D <: Dict{Symbol}, Tp <: Tuple}
    res = Tuple(typ[] for typ in typs)
    for each in source
        push!.(res, each)
    end
    Dict(zip(fields, res))
end
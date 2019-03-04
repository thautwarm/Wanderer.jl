using Wanderer
using Test

DataSource1 = Dict(
    :a => [1, 2, 3],
    :b => [2, 3, 4],
    :c => [3, 4, 5]
)

DataSource2 = Dict(
    :a => ["a", "b", "c"],
    :b => [2, 3, 4],
    :c => [3, 4, 5]
)

@testset "Wanderer.jl" begin
    @test (DataSource1 |> @select _.a + _.b + _.c => sum)[:sum] == [6, 9, 12]
    @test (DataSource1 |> @where _.a != 2, @select _.b - _.c => sub)[:sub] == [-1, -1]
    df = (DataSource1 |> @select _.(!1), @where _.c === 4)
    @test df[:b][1] == 3 && df[:c][1] == 4
    @test ["aa", "bbb", "cccc"] == (DataSource2 |> @select repeat(_.a, _.b) => a)[:a]
    f(x) = 2x + 1

    df = DataSource2 |>
    @select f(_.b) => b, _.(!b),
    @where _.c > 2, _.b > 2,
    @orderby _.b % 3

    @test df[:b] == [9, 7, 5] && df[:a] == ["c", "b", "a"] && df[:c] == [5, 4, 3]

    agg = DataSource1 |>
    @groupby (_.a + _.b - _.c) % 2 == 0 => is_even,
    @having is_even

    @test agg[:a][1] == [1, 3] && agg[:b][1] == [2, 4] && agg[:c][1] == [3, 5]

    df = DataSource1 |>
    @select _, _.a + _.b => "a + b",
    @limit 2

    @test df[Symbol("a + b")] == [3, 5]
end

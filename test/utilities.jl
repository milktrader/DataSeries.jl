module TestUtilities
  
  using Base.Test
  using Series
  using Datetime
  
  # arrays with Datetime index
    op = readseries(Pkg.dir("Series/test/data/spx.csv"))
    cl = readseries(Pkg.dir("Series/test/data/spx.csv"), value=5)
  
  # arrays with boolean values
    bt = SeriesArray([1:3], trues(3))
    ba = push!(bt, SeriesPair(4, false))

    # istrue
    @test length(istrue(ba)) == 3

    # index and value and name
    @test value(op)[1] == 92.06
    @test index(op)[1] == date(1970,1,2)
    @test name(op)[1] == name(op)[2] == name(op)[3]
end

using MarketData

bt = SeriesArray([1:3], trues(3))
ba = push!(bt, SeriesPair(4, false))

facts("Utilities") do

  context("value, index and name") do
    @fact value(op)[1] => 105.76 
    @fact index(op)[1] => firstday 
    @fact name(op)[1]  => name(op)[2] 
    @fact name(op)[2]  => name(op)[3] 
  end
  
  context("istrue") do
    @fact length(istrue(ba)) => 3
  end
  
  context("when") do
    @fact when(op, [firstday, secondday, tenthday])[1].value => 105.76 
    @fact when(op, [firstday, secondday, tenthday])[2].value => 105.22
    @fact when(op, [firstday, secondday, tenthday])[3].value => 111.14
    @fact when(op, [firstday, secondday, tenthday])[1].index => firstday
    @fact when(op, [firstday, secondday, tenthday])[2].index => secondday
    @fact when(op, [firstday, secondday, tenthday])[3].index => tenthday
  end
end

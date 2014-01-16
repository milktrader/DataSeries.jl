using MarketData

facts("IO") do

  context("values are correct") do
    @fact op[1].value  => 105.76
    @fact hi[1].value  => 106.08
    @fact lo[1].value  => 103.26
    @fact cl[1].value  => 105.22 
  end
     
  context("dates are correct") do
    @fact op[1].index  => firstday 
    @fact hi[1].index  => firstday 
    @fact lo[1].index  => firstday 
    @fact cl[1].index  => firstday
  end
end

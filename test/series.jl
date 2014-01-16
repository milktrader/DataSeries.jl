using MarketData

facts("Series") do

  context("values are correct for SeriesPair") do
    @fact op[1].value => 105.76
  end
  
  context("values are correct on operators") do
    @fact (op[1] + op[1]).value => 211.52
    #@fact (op[1] - op[1]).value => 0
    @fact (op[1] - op[1]).value => 0
    @fact (op[1] * op[1]).value => 11185.1776
    @fact (op[1] / op[1]).value => 1
    @fact op[1] / op[2]         => nothing  # since indexes don't match, nothing is returned
    @fact eval(op[1] < op[2])   => nothing  # this should be nothing since indexes don't match?
  end
       
  context("dates are correct") do
    @fact  op[1].index  => firstday
    @fact  op[2].index  => secondday
    @fact  op[10].index => tenthday
  end
  
  context("types are correct") do
    @fact typeof(op)    => ArraySeriesPairDateFloat64
    @fact typeof(op[1]) => SeriesPairDateFloat64
  end
end

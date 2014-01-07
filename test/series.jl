using MarketData

fails = 0

@context "values are correct for SeriesPair"
jtest( op[1].value == 105.76)
fails += f

@context "values are correct on operators"
jtest( (op[1] + op[1]).value == 211.52,
       (op[1] - op[1]).value == 0,
       (op[1] * op[1]).value == 11185.1776,
       (op[1] / op[1]).value == 1,
        op[1] / op[2] == nothing,                     # since indexes don't match, nothing is returned
        op[1] < op[2] == nothing)  # not sure why this works 
fails += f
     
@context "dates are correct"
jtest(op[1].index == firstday)
fails += f

@context "types are correct"
jtest(typeof(op) == ArraySeriesPairDateFloat64,
      typeof(op[1]) == SeriesPairDateFloat64)
fails += f

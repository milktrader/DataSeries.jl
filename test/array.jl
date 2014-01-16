using MarketData

nam = SeriesArray([1:3], [2:4], "test")
boo = SeriesArray([1:3], trues(3))
arr = Array(op, cl[2:end])

facts("Array") do
  
  context("boolean values are evaluated") do
    @fact sum(value(boo)) => 3
  end
  
  context( "arrays with nammes") do
    @fact nam[1].name => "test" 
    @fact nam[2].name => "test" 
    @fact nam[3].name => "test"
  end
   
   context("readseries sorts") do
     @fact op[1].value => 105.76             
     @fact op[1].index => firstday
   end
     
   context("indexing") do
     @fact op[1].index       => firstday
     @fact op[1].value       => 105.76
     @fact length(op[2:end]) => 504  
   end
   
  context("construct Array of values") do
    @fact size(arr)                    => (505,2)
    @fact round(sum(arr[2:end,2]), 2)  => 62216.27
    @fact typeof(arr)                  => Array{Float64, 2}
    @fact isnan(arr[1,2])              => true
  end
  
  context("remove rows that have namN") do
    @fact size(removenan(arr))                   => (504,2) 
    @fact isnan(sum(removenan(arr)))             => false 
    @fact length(lag(op))                        => 505 
    @fact isnan(sum([v.value for v in lag(op)])) => true
  end
  
  context("broadcast operator needs rewrite") do
  # "CAUTION: sorting NOT enforced"
  # "TODO: enforce sorting"
    @fact (op .+ cl)[1].value =>  210.98000000000002 
    @fact (op .- cl)[1].value =>  0.5400000000000063 
    @fact (op .* cl)[1].value =>  11128.067200000001   
    @fact (op ./ cl)[1].value =>  1.0051321041627068
  end
  
  context("head and tail") do
    @fact length(head(op))  => 1 
    @fact length(tail(op))  => 504 
    @fact head(op)[1].value => 105.76
  end
  
  context("lag and lead sorted array") do
    @fact isnan(lag(op)[1].value) => true 
    @fact lag(op)[2].value        => 105.76
    @fact lag(op,2)[3].value      => 105.76
    @fact lag(op)[1].index        => firstday
    @fact lead(op)[1].value       => 105.22 
    @fact lead(op)[1].index       => firstday
  end
end

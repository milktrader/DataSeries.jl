using MarketData

facts("Time") do

  context("percentchange") do
    @fact isnan(percentchange(op)[1].value)        => true 
    @fact percentchange(op)[2].value               => -0.005105900151286568
    @fact percentchange(op, method="log")[2].value => -0.005118979800715628
  end
  
  context("moving, upto") do
    @fact isnan(moving(op, mean, 10)[9].value) => true 
    @fact moving(op, mean, 10)[10].value       => 108.36399999999999
    @fact upto(op, sum)[4].value               => 424.31
  end
  
  context("bydate") do
    @fact byyear(op, 1980)[1].index => firstday  
    @fact bymonth(op, 2)[1].index   => secondmonth   
    @fact byday(op, 16)[1].index    => tenthday   
    @fact bydow(op, 5)[1].index     => secondday  
    @fact bydoy(op, 4)[1].index     => secondday
  end
  
  context("from, to and collapse") do
    @fact to(op, 1980,12,31)[end].index            => lastday - years(1) 
    @fact from(op,1981,1,2)[1].index               => firstday + days(365)  
    @fact collapse(op, maximum)[2].value           => 109.89
    @fact length(collapse(cl, last, period=month)) => 24
  end
end 

module Series

using Datetime, Iterators

import Base.show,
       Base.isless

export SeriesPair, 
       SeriesArray, 
       +, -, *, /, 
       .+, .-, .*, ./, 
       readseries, 
       removenan, 
       head, tail, 
       index, value, name, istrue, when, 
       lag, lead, 
       percentchange, 
       moving, upto,  
       fastmoving,
       byyear, bymonth, byday, bydow, bydoy, 
       from, to, collapse 
  
abstract AbstractSeriesPair

immutable SeriesPair{T, V} <: AbstractSeriesPair
  index::T
  value::V
  name::String
end

SeriesPair{T,V}(x::T,y::V) = SeriesPair{T,V}(x::T,y::V,"value")

#################################
###### isless ###################
#################################

function isless(sp1::SeriesPair, sp2::SeriesPair)
  a, b = sp1.index, sp2.index
  if !isequal(a, b)
   return isless(a, b)
  end
end

#################################
###### show #####################
#################################

function show(io::IO, p::SeriesPair)
  typeof(p.value) == Float64?
  print(io, p.index, "  ",  join([@sprintf("%.4f",x) for x in p.value]," ")):
  print(io, p.index, "  ",  p.value)
end

#################################
###### getindex #################
#################################

function getindex{T <: Date{ISOCalendar}, V}(sa::Array{SeriesPair{T, V}, 1}, mydate::Date{ISOCalendar})
  for i in 1:size(sa,1)
    if mydate == sa[i].index 
      return sa[i] 
    else 
      nothing
    end
  end
end

#################################
###### +, -, *, / ###############
#################################

# operations between two SeriesPairs
for op in [:+, :-, :*, :/, :>, :<, :>=, :<=,
           :.+, :.-, :.*, :./, :.>, :.<, :.>=, :.<=]

  @eval begin
    function ($op){T,V}(sp1::SeriesPair{T,V}, sp2::SeriesPair{T,V})
      matches = false 
      if sp1.index == sp2.index
         matches = true
         res = SeriesPair(sp1.index, ($op)(sp1.value, sp2.value))
      end
      matches == true? res: nothing  # nothing is indignity enough rather than an error
    end
  end
end

# operations between SeriesPair and Int,Float64
for op in [:+, :-, :*, :/, :.+, :.-, :.*, :./]
  @eval begin
    function ($op){T,V}(sp::SeriesPair{T,V}, var::Union(Int,Float64))
      SeriesPair(sp.index, ($op)(sp.value, var))
    end
  end
end
 
#################################
###### include ##################
#################################

  include("array.jl")
  include("io.jl")
  include("utilities.jl")
end

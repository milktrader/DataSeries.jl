#################################
# SeriesArray constructor #######
#################################

function SeriesArray{T,V}(idx::Array{T,1}, val::Array{V,1})
  #res = SeriesPair[]
  res = SeriesPair{T,V}[]
  for i = 1:size(idx,1)
    x = SeriesPair(idx[i], val[i])
    push!(res, x)
  end
  res
end

#################################
# Array method ##################
#################################

import Core.Array

function Array{T,V}(args::Array{SeriesPair{T,V},1}...) 
  
  # create array of index values from args
  allkey = typeof(args[1][1].index)[]
  for arg in args
    for ar in arg
      push!(allkey, ar.index)
    end
  end

  # and sort without duplicates
  key = sortandremoveduplicates(allkey)

  # match each arg in args with key 
  arr = fill(NaN, length(key), length(args))
    for i in 1:length(args)
      for j = 1:length(args[i])
        t = args[i][j].index .== key
        k = key[t]
        arr[k,i] = args[i][j].value 
      end
    end
  arr
end


#################################
# sortandremoveduplicates #######
#################################

function sortandremoveduplicates(x::Array)
  sx = sort(x)
  res = [sx[1]]
  for i = 2:length(sx)
    if sx[i] > sx[i-1]
    push!(res, sx[i])
    end
  end
  res
end

#################################
# removenan #####################
#################################

function removenan(x::Array)
  idx= Int[]
    for i in 1:size(x, 1)
      if ~isnan(sum(x[i,:])) # detect row doens't have an NaN
        push!(idx, i)    # keep it
      end
    end
  x[idx,:] 
end

#################################
# broadcasting ##################
#################################

#for (op, broadcaster) in ([:+, :-, :*, :/], [:.+, :.-, :.*, :./])
#  @eval begin
#    function ($op){T,V}(sa1::Array{SeriesPair{T,V},1}, sa2::Array{SeriesPair{T,V},1}) 
############        res = SeriesPair{T,V}[]
############        for i in 1:length(sa1)
############          for j in 1:length(sa2)
############            if ($op)(sa1[i], sa2[j]) != nothing 
############              push!(res, ($op)(sa1[i], sa2[j]))
############            end
############          end
############        end
#res = ($op)(($broadcaster)(sa1, sa2))
#sort(res)
#    end # function
#  end # eval
#end # loop

#################################
# head, tail ####################
#################################

head{T,V}(x::Array{SeriesPair{T,V},1}) = [x[1]]
tail{T,V}(x::Array{SeriesPair{T,V},1}) = x[2:end]

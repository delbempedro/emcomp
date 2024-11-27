"""
  ComputeTimeRetardation

Module that compute time retardation.

Dependencies:
- FindCriticalPoints

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module ComputeTimeRetardation

    include("./FindCriticalPoints.jl")
    using .FindCriticalPoints

    function TimeRetardation(time::Int, Point::Tuple{Int,Int}, c::Float64)

      time_at_max_distance::Float64, time_at_min_distance::Float64 = FindCriticalPoints.CriticalPoints(time::Int, Point::Tuple{Int,Int})

      max_distance::Float64 = FindCriticalPoints.distance(time_at_max_distance::Float64, Point::Tuple{Int,Int})
      min_distance::Float64 = FindCriticalPoints.distance(time_at_min_distance::Float64, Point::Tuple{Int,Int})

      middle_time::Float64 = (time_at_max_distance + time_at_min_distance)/2
      middle_distance::Float64 = FindCriticalPoints.distance(middle_time::Float64, Point::Tuple{Int,Int})
        
      light_time_to_propagation::Float64 = middle_distance/c

      error::Float64 = middle_distance - middle_light_propagation
      
      #light propagates more 
      if error > 0

      elseif error < 0

      else

        return middle_time

      end

      return time

    end

end
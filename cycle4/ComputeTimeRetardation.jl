"""
  ComputeTimeRetardado

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

    function TimeRetardation(current_time::Float64, Point::Tuple{Int,Int}, c::Float64)

      #compute the critical times
      time_at_max_distance::Float64, time_at_min_distance::Float64 = FindCriticalPoints.MaxMin(
      current_time::Float64, Point::Tuple{Int,Int})
      
      #compute the middle time
      middle_time::Float64 = (time_at_max_distance + time_at_min_distance)/2
      #compute the distance between the point and the trajectory at middle time
      middle_distance::Float64 = FindCriticalPoints.distance(middle_time::Float64, Point::Tuple{Int,Int})
        
      #compute ditance that light propagates between middle_time and current_time
      light_distance_propagation::Float64 = (current_time-middle_time)*c

      #compute the error
      error::Float64 = middle_distance - light_distance_propagation
      
      while error > 0.5 || error < -0.5

        if error > 0
          time_at_max_distance = middle_time
          middle_time = (middle_time+time_at_min_distance)/2

          #compute the distance between the point and the trajectory at middle time
          middle_distance = FindCriticalPoints.distance(middle_time::Float64, Point::Tuple{Int,Int})

          #compute ditance that light propagates between middle_time and current_time
          light_distance_propagation = (current_time-middle_time)*c

          #compute the error
          error = middle_distance - light_distance_propagation

        elseif error < 0

          time_at_min_distance = middle_time
          middle_time = (middle_time+time_at_max_distance)/2

          #compute the distance between the point and the trajectory at middle time
          middle_distance = FindCriticalPoints.distance(middle_time::Float64, Point::Tuple{Int,Int})

          #compute ditance that light propagates between middle_time and current_time
          light_distance_propagation = (current_time-middle_time)*c

          #compute the error
          error = middle_distance - light_distance_propagation

        end

      end
      
      #return the middle time when the module of error is less than 0.1
      return middle_time

    end

end
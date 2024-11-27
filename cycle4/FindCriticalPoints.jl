"""
  FindCriticalPoints

Module that finds the critical points in distance of the point to the trajetory.

Dependencies:
- GetComponent

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module FindCriticalPoints

  include("./GetComponent.jl")
  using .GetComponent

  omega::Float64 = 0.9*3e8 #0.9c
  delta_time::Float64 = 0.1 #time step

  function distance(time::Float64, Point::Tuple{Int,Int})

    #compute the distance between the point and the trajectory at the given time
    x::Int = GetComponent.X(time, Point)
    y::Int = GetComponent.Y(time, Point)
    distance::Float64 = sqrt((x-Point[1])^2 + (y-Point[2])^2)

    return distance
    
  end

  function CriticalPoints(time::Int64, Point::Tuple{Int,Int})
    
    #compute the distance between the point and the trajectory at current time
    current_distance::Float64 = distance(time::Float64, Point::Tuple{Int,Int})

    #compute the distance between the point and the trajectory at current time + delta time
    future_distance::Float64 = distance(time+delta_time::Float64, Point::Tuple{Int,Int})

    #compute the distance between the point and the trajectory at current time - delta time
    past_distance::Float64 = distance(time-delta_time::Float64, Point::Tuple{Int,Int})

    #if current_distance is the maximun distance
    if current_distance > future_distance && actual_distance > past_distance

        time_at_max_distance::Float64 = time
        time_at_min_distance::Float64 = pi/omega - time #the oposite point in the circle

    #if current_distance is the minimun distance
    elseif current_distance < future_distance && actual_distance < past_distance

        time_at_max_distance::Float64 = pi/omega - time #the oposite point in the circle
        time_at_min_distance::Float64 = time

    #if current_distance is the middle distance and future_distance are bigger than current_distance
    elseif current_distance < future_distance && actual_distance > past_distance
    
        #find the max distance following the path until the distance decreases
        current_max_time::Float64 = time
        potencial_max_time::Float64 = time + delta_time
        while distance(potencial_max_time_time, Point) > distance(current_max_time, Point)
            current_max_time = potencial_max_time
            potencial_max_time += delta_time
        end

        time_at_max_distance::Float64 = current_max_time

        #find the min distance following the path until the distance increases
        current_min_time::Float64 = time
        potencial_min_time::Float64 = time - delta_time
        while distance(potencial_min_time_time, Point) < distance(current_min_time, Point)
            current_min_time::Float64 = potencial_min_time
            potencial_min_time::Float64 -= delta_time
        end

        time_at_min_distance::Float64 = current_min_time

    #if current_distance is the middle distance and past_distance are bigger than current_distance
    elseif current_distance > future_distance && actual_distance < past_distance

        #find the max distance following the path until the distance decreases
        current_max_time::Float64 = time
        potencial_max_time::Float64 = time - delta_time
        while distance(potencial_max_time_time, Point) > distance(current_max_time, Point)
            current_max_time = potencial_max_time
            potencial_max_time -= delta_time
        end

        time_at_max_distance::Float64 = current_max_time

        #find the min distance following the path until the distance increases
        current_min_time::Float64 = time
        potencial_min_time::Float64 = time + delta_time
        while distance(potencial_min_time_time, Point) < distance(current_min_time, Point)
            current_min_time = potencial_min_time
            potencial_min_time += delta_time
        end

        time_at_min_distance::Float64 = current_min_time

    end

    return time_at_max_distance, time_at_min_distance

  end

end
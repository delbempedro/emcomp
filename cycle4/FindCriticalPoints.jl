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

  omega::Float64 = 0.9 #0.9c
  R::Float64 = 1.0 #radius
  delta_time::Float64 = 1e-5 #time step

  function distance(time::Float64, Point::Tuple{Int,Int})

    #compute the distance between the point and the trajectory at the given time
    x::Float64 = GetComponent.X(time, Point)
    y::Float64 = GetComponent.Y(time, Point)
    distance::Float64 = sqrt(x^2 + y^2)

    return distance
    
  end

  function MaxMin(time::Float64, Point::Tuple{Int,Int})

    number_of_turns = div(time*omega, 2*pi)
    theta_at_min_distance = 2*pi*number_of_turns/omega
    theta_at_max_distance = 2*pi*(number_of_turns+0.5)/omega

    return theta_at_max_distance, theta_at_min_distance

  end

  function realCriticalPoints(time::Float64, Point::Tuple{Int,Int})

    max_distance::Float64 = abs(sqrt(Point[1]^2 + Point[2]^2) + R)
    min_distance::Float64 = abs(sqrt(Point[1]^2 + Point[2]^2) - R)

    time_at_max_distance::Float64 = time
    time_at_min_distance::Float64 = time
    print("TimeAtMaxDistance: $time_at_max_distance", " TimeAtMinDistance: $time_at_min_distance")
    while distance(time_at_max_distance, Point) - max_distance < 0.1 && time_at_max_distance <= 0
      time_at_max_distance -= delta_time
      println("TimeAtMaxDistance: $time_at_max_distance")
    end
    
    while distance(time_at_min_distance, Point) - min_distance < 0.1 && time_at_min_distance <= 0
      time_at_min_distance -= delta_time
    end
    println("TimeAtMinDistance: $time_at_min_distance")
    return time_at_max_distance, time_at_min_distance
    
  end

  function CriticalPoints(time::Float64, Point::Tuple{Int,Int})

    #compute the distance between the point and the trajectory at current time
    current_distance::Float64 = distance(time::Float64, Point::Tuple{Int,Int})

    #compute the distance between the point and the trajectory at current time - delta time
    past_distance::Float64 = distance(time-delta_time::Float64, Point::Tuple{Int,Int})

    #define the current critical time
    current_critical_time::Float64 = time

    #if current_distance is greater than past_distance
    if current_distance > past_distance

      potencial_critical_time = time - delta_time
      while distance(potencial_critical_time_time, Point) < distance(current_critical_time, Point)
        current_critical_time = potencial_critical_time
        potencial_critical_time -= delta_time
        println("I'm here!")
      end

    #if current_distance is less than past_distance
    elseif current_distance < past_distance

      potencial_critical_time = time + delta_time
      while distance(potencial_critical_time, Point) > distance(current_critical_time, Point)
        current_critical_time = potencial_critical_time
        potencial_critical_time += delta_time
        println("I'm here!!")
      end

    end

    println("I'm here!!!")

    first_time_at_critical_distance::Float64 = current_critical_time
    second_time_at_critical_distance::Float64 = pi/omega - first_time_at_critical_distance #the oposite point in the circle

    #compute witch distance is greater between first_time_at_critical_distance and second_time_at_critical_distance 
    if distance(first_time_at_critical_distance, Point) < distance(second_time_at_critical_distance, Point)

      return first_time_at_critical_distance, second_time_at_critical_distance
    else

      return second_time_at_critical_distance, first_time_at_critical_distance

    end
    
  end

end
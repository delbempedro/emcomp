"""
  ComputeRetardationTime

Module that compute time retardation.

Dependencies:
- GetComponent.jl
- Roots.jl

Since:
- 12/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module ComputeRetardationTime

  using Roots
  include("./GetComponent.jl")
  using .GetComponent


  function TimeRetardation(time::Float64, Point::Tuple{Int,Int}, c::Float64)

    #defines the function whose root is found
    function_whose_find_root(time_retardation::Float64) = time - time_retardation - ( (GetComponent.X(time, Point)^2 + GetComponent.Y(time, Point)^2)^0.5 )/c

    #defines the period
    T::Float64 = 2*pi/GetComponent.Constants("omega")

    #defines the radius
    R::Float64 = GetComponent.Constants("R")

    #defines the interval where the root is found
    precision = T/1000
    start = time - ((Point[1]^2 + Point[2]^2)^0.5 + R)/c - precision
    finish = time
    
    #finds the root
    raiz = find_zero(function_whose_find_root, (start, finish), Roots.Secant())

    return raiz

  end

end
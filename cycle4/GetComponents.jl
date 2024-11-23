"""
  GetComponents

Module that returns the components of a vector given a point an instant.


Dependencies:
-

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""

module GetComponents

  function X(R::Float64, omega::Float64, t::Int, Point::Vector{Int,Int})
    
    return R*cos(omega*t) + Point[1]
    
  end

  function Y(R::Float64, omega::Float64, t::Int, Point::Vector{Int,Int})
    
    return R*sin(omega*t) + Point[2]
    
  end

  function Vx(R::Float64, omega::Float64, t::Int, Point::Vector{Int,Int})
    
    return -R*omega*sin(omega*t)
    
  end

  function Vy(R::Float64, omega::Float64, t::Int, Point::Vector{Int,Int})
    
    return R*omega*cos(omega*t)
    
  end

  function Ax(R::Float64, omega::Float64, t::Int, Point::Vector{Int,Int})

    return -R*omega^2*cos(omega*t)

  end

  function Ay(R::Float64, omega::Float64, t::Int, Point::Vector{Int,Int})

    return -R*omega^2*sin(omega*t)

  end

end
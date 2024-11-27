"""
  GetComponent

Module that returns the components of a vector given a point an instant.

Dependencies:
-

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module GetComponent

  #define the constants of the moviment
  omega::Float64 = 0.9 #0.9c
  R::Float64 = 1.0 #radius

  function X(t::Float64, Point::Tuple{Int, Int})
    
    return R*cos(omega*t) + Point[1]
    
  end

  function Y(t::Float64, Point::Tuple{Int, Int})
    
    return R*sin(omega*t) + Point[2]
    
  end

  function Vx(t::Float64)
    
    return -R*omega*sin(omega*t)
    
  end

  function Vy(t::Float64)
    
    return R*omega*cos(omega*t)
    
  end

  function Ax(t::Float64)

    return -R*omega^2*cos(omega*t)

  end

  function Ay(t::Float64)

    return -R*omega^2*sin(omega*t)

  end

end
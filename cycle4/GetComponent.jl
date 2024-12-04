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
  c::Float64 = 1.0 #speed of light

  function Constants(constante::String)

    if constante == "omega"
      return omega
    elseif constante == "R"
      return R
    elseif constante == "c"
      return c
    end
    
  end

  function X(t::Float64, Point::Tuple{Int, Int})
    
    return Point[1] - R*cos(omega*t)
    
  end

  function Y(t::Float64, Point::Tuple{Int, Int})
    
    return Point[2] - R*sin(omega*t)
    
  end

  function Vx(t::Float64)
    
    return R*omega*sin(omega*t)
    
  end

  function Vy(t::Float64)
    
    return -R*omega*cos(omega*t)
    
  end

  function Ax(t::Float64)

    return R*omega^2*cos(omega*t)

  end

  function Ay(t::Float64)

    return R*omega^2*sin(omega*t)

  end

end
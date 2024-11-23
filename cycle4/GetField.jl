"""
  GetField

Module that returns the field given the position and time.

Dependencies:
-

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module GetField

  function Ex(x::Float64, y::Float64, Vx::Float64, Vy::Float64, ay::Float64, c::Float64)

    commom_factor = ( (1-Vx/c-Vy/c)^(-3) )*( (x^2+y^2)^(-1/2) )
    first_term = (1-Vx/c)*(1-(Vx/c)^2-(Vy/c)^2)*( (x^2+y^2)^(-1/2) )
    second_term = ay*( c^(-3) )*(y*Vx-x*Vy)

    return commom_factor*(first_term + second_term)

  end

  function Ey(x::Float64, y::Float64, Vx::Float64, Vy::Float64, ax::Float64, c::Float64)

    commom_factor = ( (1-Vx/c-Vy/c)^(-3) )*( (x^2+y^2)^(-1/2) )
    first_term = (1-Vy/c)*(1-(Vx/c)^2-(Vy/c)^2)*( (x^2+y^2)^(-1/2) )
    second_term = ax*( c^(-3) )*(x*Vy-y*Vx)

    return commom_factor*(first_term + second_term)

  end

end
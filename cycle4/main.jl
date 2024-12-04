"""
  cycle3

Module that...

To run the main() function, call `julia main.jl` on the terminal.

Dependencies:
- GetComponent
- GetField
- ComputeTimeRetardation
- PlotField

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module cycle4

  include("./GetComponent.jl")
  using .GetComponent
  include("./GetField.jl")
  using .GetField
  include("./ComputeRetardationTime.jl")
  using .ComputeRetardationTime
  include("./SaveFields.jl")
  using .SaveFields

  function main()

    #define the constants
    c::Float64 = GetComponent.Constants("c") #speed of light
    R::Float64 = GetComponent.Constants("R") #radius
    side::Int = 100

    #define the final time
    final_time::Int = 100
    
    #initialize the fields matrix with zeros
    Ex::Matrix{Float64} = zeros(side, side)
    Ey::Matrix{Float64} = zeros(side, side)

    #compute the fields for each time
    for time in 0:final_time

      #compute the fields for each point
      for weight in 1:side
        for height in 1:side

          #converts the time(Int) to operational_time(Float64)
          operational_time::Float64 = time*1.0

          #define the point
          Point::Tuple{Int, Int} = (weight, height)

          #define the time retardation
          time_ret::Float64 = ComputeRetardationTime.TimeRetardation(operational_time, Point, c)

          #define the components
          x::Float64 = GetComponent.X(time_ret, Point)
          y::Float64 = GetComponent.Y(time_ret, Point)
          Vx::Float64 = GetComponent.Vx(time_ret)
          Vy::Float64 = GetComponent.Vy(time_ret)
          Ax::Float64 = GetComponent.Ax(time_ret)
          Ay::Float64 = GetComponent.Ay(time_ret)

          #compute the field
          Ex[weight, height] = GetField.Ex(x, y, Vx, Vy, Ay, c)
          Ey[weight, height] = GetField.Ey(x, y, Vx, Vy, Ax, c)

        end
      end

      #save the fields
      SaveFields.SaveField(Ex, Ey, side, time)

    end

  end

end
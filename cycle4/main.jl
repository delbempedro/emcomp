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
  include("./ComputeTimeRetardation.jl")
  using .ComputeTimeRetardation
  include("./PlotField.jl")
  using .PlotField

  function main()

    #define the constants
    c::Float64 = 3e8 #speed of light
    side::Int = 100

    #define the final time
    final_time::Int = 10
    
    Ex::Matrix{Float64} = zeros(side, side)
    Ey::Matrix{Float64} = zeros(side, side)
    
    for time in 0:final_time

      for weight in 1:side
        for height in 1:side

          #define the point
          Point::Tuple{Int, Int} = (weight, height)

          #define the time retardation
          time_ret = ComputeTimeRetardation.TimeRetardation(time, Point, c)

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

          #plot the field
          PlotField.Plot(Ex, Ey, side, time)

        end
      end

    end


  end

end
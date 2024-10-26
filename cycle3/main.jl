"""
  cycle3

Module that implements a 2D FDTD solver for electromagnetic waves using loops for field updates.

To run the main() function, call `julia main.jl` on the terminal.

Dependencies:
- UpdateFields.jl

Since:
- 10/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module cycle3

  include("./UpdateFields.jl")
  using .UpdateFields

  function main()

  # defines phisicial consts
  sc::Float64 = 0.35 #courant parameter (c*delta(t)/delta(x))
  er::Tuple{Float64, Float64} = (1.0, 0.1) #relative eletric permitivity
  E_initial::Float64 = 1.0 #initial E field
  omega::Float64 = 3.14 #w*delta_t

  # defines initial and final time
  side::Int = 100 #mesh size
  time::Int = -1
  final_t::Int = 2000 #final time
  
  # initializes By times c field
  cBy::Matrix{Float64} = zeros(side, side)
  for i in 2:2:side cBy[1, i] = E_initial*cos(omega*time) end

  # initializes Ez field
  time += 1
  Ez::Matrix{Float64} = zeros(side, side) 
  for i in 1:2:side Ez[1, i] = E_initial*cos(omega*time) end

  # initializes Bx times c field
  cBx::Matrix{Float64} = zeros(side, side)

  UpdateFields.update_fields(cBx::Matrix{Float64}, cBy::Matrix{Float64}, Ez::Matrix{Float64},
  er::Tuple{Float64, Float64}, E_initial::Float64, omega::Float64, sc::Float64, side::Int, final_t::Int)

  end

end
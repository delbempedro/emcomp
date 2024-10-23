"""
  cycle3

Module that implements a 2D FDTD solver for electromagnetic waves using loops for field updates.

To run the main() function, call `julia main.jl` on the terminal.

Dependencies:
- Plots.jl

Since:
- 10/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module cycle3

  include("./BoundaryConditions.jl")
  using .BoundaryConditions
  using Plots

  function main()

  # defines phisicial consts
  sc::Float64 = 0.5 #courant parameter (c*delta(t)/delta(x))
  er::Tuple{Float64, Float64} = (1.0, 0.5) #permittivity of free space
  E_initial::Float64 = 1.0 #initial E field

  # defines initial and final time
  side::Int = 100 #mesh size
  final_t::Int = 10000 #final time

  # initializes Ez field
  Ez::Matrix{Float64} = zeros(side, side) 
  for i in 1:side Ez[i, 1] = 1.0 end

  cBy::Matrix{Float64} = zeros(side, side) # initializes By tiems c field
  cBx::Matrix{Float64} = zeros(side, side) # initializes Bx times c field

  # time loop
  for t in 1:final_t

    # atualizes magnectic field
    for i in 2:2:side
      for j in 2:2:side

          cBx[i, j] += sc * (get_Ez.BoundaryConditions(Ez,i, j+1) - get_Ez.BoundaryConditions(Ez,i, j-1))
          cBy[i, j] -= sc * (get_Ez.BoundaryConditions(Ez,i+1, j) - get_Ez.BoundaryConditions(Ez,i-1, j))
        
      end
    end

    # atualizes eletric field
    for i in 1:2:side
      for j in 1:2:side

        Ez[i, j] += (sc / er[1]) * ((get_cBy.BoundaryConditions(cBy,i+1, j) - get_cBy.BoundaryConditions(cBy,i-1, j)) - (get_cBy.BoundaryConditions(cBy,i, j+1) - get_cBy.BoundaryConditions(cBy,i, j-1)))

      end
    end

    # Plot
    if t % 10 == 0
      heatmap(Ez', title="Campo Elétrico - Passo $t", c=:inferno)
      savefig("campo_eletrico_$t.png") # save the figure as a PNG file
    end

  end

  end

end
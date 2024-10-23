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
  sc::Float64 = 0.45 #courant parameter (c*delta(t)/delta(x))
  er::Tuple{Float64, Float64} = (1.0, 10.0) #permittivity of free space
  E_initial::Float64 = 1.0 #initial E field

  # defines initial and final time
  side::Int = 100 #mesh size
  final_t::Int = 10000 #final time

  # initializes Ez field
  Ez::Matrix{Float64} = zeros(side, side) 
  for i in 1:side Ez[1, i] = 1.0 end

  cBy::Matrix{Float64} = zeros(side, side) # initializes By times c field
  cBx::Matrix{Float64} = zeros(side, side) # initializes Bx times c field

  # time loop
  for t in 0:final_t

    current_er = er[1]

    if t % 2 == 0 # even time

      # atualizes eletric field
      for i in 1:side
        for j in 1:side
          if i >= 50 && i <= 75 && j >= 50 && j <= 75 current_er = er[2] end
          Ez[i, j] += (sc / current_er) * ((BoundaryConditions.get_cBy(cBy, i+1, j, side) - BoundaryConditions.get_cBy(cBy, i-1, j, side)) - (BoundaryConditions.get_cBx(cBx, i, j+1, side) - BoundaryConditions.get_cBx(cBx, i, j-1, side)))

        end
      end

    else # odd time

      # atualizes magnectic field
      for i in 2:side
        for j in 2:side

            cBx[i, j] += sc * (BoundaryConditions.get_Ez(Ez, i, j+1, side) - BoundaryConditions.get_Ez(Ez, i, j-1, side))
            cBy[i, j] -= sc * (BoundaryConditions.get_Ez(Ez, i+1, j, side) - BoundaryConditions.get_Ez(Ez, i-1, j, side))
          
        end
      end

    end


    # Plot
    if t % 100 == 0
      heatmap(Ez', title="Campo Elétrico - Passo $t", c=:inferno)
      savefig("campo_eletrico_$t.png") # save the figure as a PNG file
    end

  end

  end

end
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

  using Plots

  function main()

  # defines phisicial consts
  sc::Float64 = 0.5 #courant parameter (c*delta(t)/delta(x))
  er::Tuple{Float64, Float64} = (1.0, 0.5) #permittivity of free space
  E_initial::Float64 = 100.0 #initial E field

  # defines initial and final time
  side::Int = 10 #mesh size
  final_t::Int = 1000 #final time

  # initializes Ez field
  Ez::Matrix{Float64} = zeros(side, side)  
  Ez[1, :] .= E_initial 

  cBy::Matrix{Float64} = zeros(side, side) # initializes By tiems c field
  cBx::Matrix{Float64} = zeros(side, side) # initializes Bx times c field

  # time loop
  for t in 1:final_t

    # atualizes magnectic field
    for i in 1:side
      for j in 1:side

        if i+1 <= side && j+1 <= side
          cBx[i, j] += sc * (Ez[i, j+1] - Ez[i, j])
          cBy[i, j] -= sc * (Ez[i+1, j] - Ez[i, j])
        elseif i+1 <= side
          cBx[i, j] += sc * (- Ez[i, j])
          cBy[i, j] -= sc * (Ez[i+1, j] - Ez[i, j])
        elseif j+1 <= side
          cBx[i, j] += sc * (Ez[i, j+1] - Ez[i, j])
          cBy[i, j] -= sc * (- Ez[i, j])
        else
          cBx[i, j] += sc * (- Ez[i, j])
          cBy[i, j] -= sc * (- Ez[i, j])
        
        end
      end
    end

    # atualizes eletric field
    for i in 1:side-1
      for j in 1:side-1

        if i-1 >= 1 && j-1 >= 1
          Ez[i, j] += (sc / er[1]) * ((cBy[i, j] - cBy[i-1, j]) - (cBx[i, j] - cBx[i, j-1]))
        else
          Ez[i, j] += (sc / er[1]) * (cBy[i, j] - cBx[i, j])
        end

      end
    end

    # Plot
    if t % 50 == 0
      heatmap(Ez', title="Campo Elétrico - Passo $t", c=:inferno)
      savefig("campo_eletrico_$t.png") # save the figure as a PNG file
    end

  end

  end

end
"""
  PlotField

Module that plots the fields.

Dependencies:
- Plots

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module PlotField

  using Plots

  function Plot(Ex::Matrix{Float64}, Ey::Matrix{Float64}, side::Int, time::Int)
    
    for i in 1:5:side
        for j in 1:5:side

            #initial point of the vector
            x = i
            y = j
            # final point of the vector
            dx = Ex[i,j]
            dy = Ey[i,j]
              
            # plot a line from initial point to initial point + vector(field)
            plot!([y, y + dy], [x, x + dx], lw=2, arrow=:arrow, arrowsize=0.25, color=:blue, legend=false)

            end
        end

        plot!()

        # saves the plot
        Plots.savefig("EletricField$time.png")

  end

end
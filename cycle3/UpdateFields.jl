"""
  UpdateFields

Update value of the fields and plot the Ez field every 10 time steps.

Dependencies:
- Plots.jl
- GetFields.jl

Since:
- 10/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module UpdateFields

    include("./GetFields.jl")
    using .GetFields
    using Plots

    function update_fields(cBx::Matrix{Float64}, cBy::Matrix{Float64}, Ez::Matrix{Float64},
        er::Tuple{Float64, Float64}, E_initial::Float64, omega::Float64, sc::Float64,
        height::Int, width::Int, final_t::Int, lens::Vector{Tuple{Int, Int}}, lens_contour::Vector{Tuple{Int, Int}})

        # time loop
        for time in 0:final_t

            if time % 2 == 0 # even time

            # atualizes eletric field
            for i in 1:2:height
                for j in 3:2:width-1 # zero in the boundary

                current_er = er[1]

                if i == 1 # first line Ez
                    Ez[1, j] = E_initial*cos(omega*time)
"""                elseif i == 5 && j != 25
                    Ez[i, j] = 0.0"""
                else # other cases
                    if i <= 100 && j <= 100 if (i,j) in lens current_er = er[2] end end # changes er 
                    Ez[i, j] += (sc / current_er) * ((GetFields.get_cBy(cBy, i, j+1, height, width, omega, time, E_initial) - GetFields.get_cBy(cBy, i, j-1, height, width, omega, time, E_initial))
                    - (GetFields.get_cBx(cBx, i+1, j, height, width, omega, time, E_initial) - GetFields.get_cBx(cBx, i-1, j, height, width, omega, time, E_initial)))
                end

                end
            end

            else # odd time

            # atualizes magnectic field
            for i in 1:height
                for j in 1:width

                if i%2 == 1

                    if j%2 == 0

                    if i == 1
                        cBy[1, j] = E_initial*cos(omega*time)
                    else
                        cBy[i, j] += sc * (GetFields.get_Ez(Ez, i, j+1, height, width, omega, time, E_initial) - GetFields.get_Ez(Ez, i, j-1, height, width, omega, time, E_initial))
                    end

                end
                    
                else

                    if j%2 == 1
                        cBx[i, j] -= sc * (GetFields.get_Ez(Ez, i+1, j, height, width, omega, time, E_initial) - GetFields.get_Ez(Ez, i-1, j, height, width, omega, time, E_initial))
                    end

                end

                end
            end

            end


            # Plot Ez with heatmap
            heatmap(Ez', title="Campo Elétrico", c=:inferno, xlabel="X", ylabel="Y", colorbar_title="Ez")
            scatter!(lens_contour, marker=:circle, markersize=3, color="white", legend=false)
            # Save PNG figure
            savefig("campo_eletrico_$time.png")


        end

    end

end
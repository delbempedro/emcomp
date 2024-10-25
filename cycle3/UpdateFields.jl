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
        er::Tuple{Float64, Float64}, E_initial::Float64, omega::Float64, sc::Float64, side::Int, final_t::Int)

        # time loop
        for time in 0:final_t

            current_er = er[1]

            if time % 2 == 0 # even time

            
            # atualizes eletric field
            for i in 1:2:side
                for j in 1:2:side

                #if i >= 50 && i <= 75 && j >= 50 && j <= 75 current_er = er[2] end
                if i == 1 # first line Ez
                    Ez[1, j] = E_initial*cos(omega*time)      
                elseif j == 1 || i == side || j == side # boundary conditions
                    Ez[i, j] = 0.0
                else # other cases
                    Ez[i, j] += (sc / current_er) * ((GetFields.get_cBy(cBy, i+1, j, side) - GetFields.get_cBy(cBy, i-1, j, side))
                    - (GetFields.get_cBx(cBx, i, j+1, side) - GetFields.get_cBx(cBx, i, j-1, side)))
                end

                end
            end

            else # odd time

            # atualizes magnectic field
            for i in 1:side
                for j in 1:side

                if i%2 == 1

                    if j%2 == 0

                    if i == 1
                        cBy[i, j] = E_initial*cos(omega*time)
                    else
                        cBy[i, j] += sc * (GetFields.get_Ez(Ez, i+1, j, side) - GetFields.get_Ez(Ez, i-1, j, side))
                    end

                    end

                else

                    if j%2 == 0
                    cBx[i, j] += sc * (GetFields.get_Ez(Ez, i, j+1, side) - GetFields.get_Ez(Ez, i, j-1, side))
                    end

                end

                end
            end

            end


            # Plot
            if time % 10 == 0
            heatmap(Ez', title="Campo Elétrico - Passo $time", c=:inferno)
            savefig("campo_eletrico_$time.png") # save the figure as a PNG file
            end

        end
    end

end
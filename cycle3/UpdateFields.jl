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
        mesh = zeros(Float64, side, side)
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
                else # other cases
                    Ez[i, j] += (sc / current_er) * ((GetFields.get_cBy(cBy, i, j+1, side, omega, time, E_initial) - GetFields.get_cBy(cBy, i, j-1, side, omega, time, E_initial))
                    - (GetFields.get_cBx(cBx, i+1, j, side, omega, time, E_initial) - GetFields.get_cBx(cBx, i-1, j, side, omega, time, E_initial)))
                    #println(Ez[i, j],GetFields.get_cBy(cBy, i+1, j, side, omega, time, E_initial),GetFields.get_cBy(cBy, i-1, j, side, omega, time, E_initial),GetFields.get_cBx(cBx, i, j+1, side, omega, time, E_initial),GetFields.get_cBx(cBx, i, j-1, side, omega, time, E_initial), " ", i, " ", j)
                end
                #mesh[i, j] = 200.0 

                end
            end

            else # odd time

            # atualizes magnectic field
            for i in 1:side
                for j in 1:side

                if i%2 == 1

                    if j%2 == 0

                    if i == 1
                        cBy[1, j] = E_initial*cos(omega*time)
                    else
                        cBy[i, j] += sc * (GetFields.get_Ez(Ez, i, j+1, side, omega, time, E_initial) - GetFields.get_Ez(Ez, i, j-1, side, omega, time, E_initial))
                    end
                        #mesh[i, j] = 100.0
                        #println(cBy[i, j]," ", GetFields.get_Ez(Ez, i, j+1, side, omega, time, E_initial)," ", GetFields.get_Ez(Ez, i, j-1, side, omega, time, E_initial), " ", i, " ", j)
                    end
                    
                else

                    if j%2 == 1
                        cBx[i, j] += sc * (GetFields.get_Ez(Ez, i+1, j, side, omega, time, E_initial) - GetFields.get_Ez(Ez, i-1, j, side, omega, time, E_initial))
                        #println(cBx[i, j]," ", GetFields.get_Ez(Ez, i+1, j, side, omega, time, E_initial)," ", GetFields.get_Ez(Ez, i-1, j, side, omega, time, E_initial), " ", i, " ", j)

                    end
                    #mesh[i, j] = 50.0 

                end

                end
            end

            end


            # Plot
            if time % 100 == 0
                heatmap(Ez', title="Campo Elétrico - Passo $time", c=:inferno)
                savefig("campo_eletrico_$time.png") # save the figure as a PNG file
            end
"""            if time % 10 == 0
            heatmap(mesh', title="Campo Elétrico - Passo $time", c=:inferno)
            savefig("campo_eletrico_$time.png") # save the figure as a PNG file
            end"""

        end
    end

end
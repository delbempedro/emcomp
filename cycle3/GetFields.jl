"""
  GetFields

Returns value of Bx, By and Ez fields considering the boundary conditions.

Dependencies:
- 

Since:
- 10/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module GetFields

    export get_cBx, get_cBy, get_Ez

    # returns value of cBx in the point (i,j)
    function get_cBx(mesh::Matrix{Float64}, i::Int, j::Int, side::Int, omega::Float64, time::Int, E_initial::Float64)

        return mesh[i, j]

    end

    # returns value of cBy in the point (i,j)
    function get_cBy(mesh::Matrix{Float64}, i::Int, j::Int, side::Int, omega::Float64, time::Int, E_initial::Float64)

        return mesh[i, j]

    end

    # returns value of Ez in the point (i,j)
    function get_Ez(mesh::Matrix{Float64}, i::Int, j::Int, side::Int, omega::Float64, time::Int, E_initial::Float64)

        if  j <= 1 || j >= side || i <= 0 || i >= side # boundary condition

            return 0.0

        elseif i == 1 # first line Ez

            return mesh[1, j] = E_initial*cos(omega*time)

        else # normal condition

            return mesh[i, j]

        end

    end

end
"""
  MeshGenerator

Returns value of Bx,By and Ez fields considering the boundary conditions.

Dependencies:
- 

Since:
- 09/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module BoundaryConditions

    export get_cBx, get_cBy, get_Ez
    w::Float64 = 1.2
    delta_t::Float64 = 0.5/(3e8) #sc/(c*delta_x) (delta_x=1)

    # returns value of cBx in the point (i,j)
    function get_cBx(mesh::Matrix{Float64}, i::Int, j::Int, side::Int)

        if i >= 1 && i <= side && j >= 1 && j <= side #normal condition

            return mesh[i, j]

        else #boundary condition

            return 0.0

        end

    end

    # returns value of cBy in the point (i,j)
    function get_cBy(mesh::Matrix{Float64}, i::Int, j::Int, side::Int)

        if i <= 0 #initial value of cBy

            return sin(w*delta_t)

        elseif i <= side && j >= 1 && j <= side #normal condition

            return mesh[i, j]

        else #boundary condition

            return 0.0 

        end

    end

    # returns value of Ez in the point (i,j)
    function get_Ez(mesh::Matrix{Float64}, i::Int, j::Int, side::Int)

        if i >= 1 && i <= side && j >= 1 && j <= side #normal condition

            return mesh[i, j]

        else #boundary condition

            return 0.0

        end

    end

end
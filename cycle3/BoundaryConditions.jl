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
    k::Float64 = 400e-9
    delta_x::Float64 = 1.5e8

    # returns value of cBx in the point (i,j)
    function get_cBx(mesh::Matrix{Float64}, i::Int, j::Int, side::Int)

        if i >= 1 && i <= side && j>= 1 && j <= side #normal condition

            return mesh[i, j]

        else #boundary condition

            return 0.0

        end

    end

    # returns value of cBy in the point (i,j)
    function get_cBy(mesh::Matrix{Float64}, i::Int, j::Int, side::Int)
        #println(1.0/(3.0e8)*sin(-k*delta_x))
        if j <= 0 #initial value of cBy
            println(sin(-k*delta_x))
            return sin(-k*delta_x)

        elseif i >= 1 && i <= side && j <= side #normal condition

            return mesh[i, j]

        else #boundary condition

            return 0.0 

        end

    end

    # returns value of Ez in the point (i,j)
    function get_Ez(mesh::Matrix{Float64}, i::Int, j::Int, side::Int)

        if i >= 1 && i <= side && j>= 1 && j <= side #normal condition

            return mesh[i, j]

        else #boundary condition

            return 0.0

        end

    end

end
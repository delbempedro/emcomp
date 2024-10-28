"""
  cycle3

Module that implements a 2D FDTD solver for electromagnetic waves using loops for field updates.

To run the main() function, call `julia main.jl` on the terminal.

Dependencies:
- UpdateFields.jl

Since:
- 10/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module cycle3

  include("./UpdateFields.jl")
  using .UpdateFields

  function main()

  # defines phisicial consts
  sc::Float64 = 0.35 #courant parameter (c*delta(t)/delta(x))
  er::Tuple{Float64, Float64} = (1.0, 10.0) #relative eletric permitivity
  E_initial::Float64 = 1.0 #initial E field
  omega::Float64 = pi #w*delta_t

  # defines initial and final time
  side::Int = 101 #mesh size
  time::Int = -1
  final_t::Int = 400 #final time

  len_points::Vector{Tuple{Int, Int}} = [(50, 99), (49, 99), (51, 98), (48, 98), (51, 97), (48, 97), (52, 96), (47, 96), (52, 95), (47, 95), (53, 94), (46, 94), (53, 93), (46, 93), (54, 92), (45, 92), (54, 91), (45, 91), (55, 90), (44, 90), (55, 89), (44, 89), (55, 88), (44, 88), (56, 87), (43, 87), (56, 86), (43, 86), (57, 85), (42, 85), (57, 84), (42, 84), (57, 83), (42, 83), (58, 82), (41, 82), (58, 81), (41, 81), (58, 80), (41, 80), (59, 79), (40, 79), (59, 78), (40, 78), (59, 77), (40, 77), (59, 76), (40, 76), (60, 75), (39, 75), (60, 74), (39, 74), (60, 73), (39, 73), (60, 72), (39, 72), (61, 71), (38, 71), (61, 70), (38, 70), (61, 69), (38, 69), (61, 68), (38, 68), (61, 67), (38, 67), (62, 66), (37, 66), (62, 65), (37, 65), (62, 64), (37, 64), (62, 63), (37, 63), (62, 62), (37, 62), (62, 61), (37, 61), (62, 60), (37, 60), (62, 59), (37, 59), (63, 58), (36, 58), (63, 57), (36, 57), (63, 56), (36, 56), (63, 55), (36, 55), (63, 54), (36, 54), (63, 53), (36, 53), (63, 52), (36, 52), (63, 51), (36, 51), (63, 50), (36, 50), (63, 49), (36, 49), (63, 48), (36, 48), (63, 47), (36, 47), (63, 46), (36, 46), (63, 45), (36, 45), (63, 44), (36, 44), (63, 43), (36, 43), (63, 42), (36, 42), (63, 41), (36, 41), (62, 40), (37, 40), (62, 39), (37, 39), (62, 38), (37, 38), (62, 37), (37, 37), (62, 36), (37, 36), (62, 35), (37, 35), (62, 34), (37, 34), (62, 33), (37, 33), (61, 32), (38, 32), (61, 31), (38, 31), (61, 30), (38, 30), (61, 29), (38, 29), (61, 28), (38, 28), (60, 27), (39, 27), (60, 26), (39, 26), (60, 25), (39, 25), (60, 24), (39, 24), (59, 23), (40, 23), (59, 22), (40, 22), (59, 21), (40, 21), (59, 20), (40, 20), (58, 19), (41, 19), (58, 18), (41, 18), (58, 17), (41, 17), (57, 16), (42, 16), (57, 15), (42, 15), (57, 14), (42, 14), (56, 13), (43, 13), (56, 12), (43, 12), (55, 11), (44, 11), (55, 10), (44, 10), (55, 9), (44, 9), (54, 8), (45, 8), (54, 7), (45, 7), (53, 6), (46, 6), (53, 5), (46, 5), (52, 4), (47, 4), (52, 3), (47, 3), (51, 2), (48, 2), (51, 1), (48, 1), (50, 0), (49, 0)]
  
  # initializes By times c field
  cBy::Matrix{Float64} = zeros(side, side)
  for i in 2:2:side cBy[1, i] = E_initial*cos(omega*time) end

  # initializes Ez field
  time += 1
  Ez::Matrix{Float64} = zeros(side, side) 
  for j in 3:2:side-1 Ez[1, j] = E_initial*cos(omega*time) end

  # initializes Bx times c field
  cBx::Matrix{Float64} = zeros(side, side)

  UpdateFields.update_fields(cBx::Matrix{Float64}, cBy::Matrix{Float64}, Ez::Matrix{Float64},
  er::Tuple{Float64, Float64}, E_initial::Float64, omega::Float64, sc::Float64, side::Int, final_t::Int, len_points::Vector{Tuple{Int, Int}})

  end

end
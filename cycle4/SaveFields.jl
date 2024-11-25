"""
  SaveFields

Module that plots the fields.

Dependencies:
- Plots

Since:
- 11/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
module SaveFields

  function SaveField(Ex::Matrix{Float64}, Ey::Matrix{Float64}, side::Int, time::Int)
    
    #write the values of the fields in a file 
    open("EletricField$time.txt", "w") do arquivo

      for i in 1:side
        for j in 1:side
          write(arquivo, "$(Ex[i,j]) $(Ey[i,j])\n")
        end
      end

    end

  end
end
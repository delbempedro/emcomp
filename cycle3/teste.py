#defines phisicial consts
c = 3e8 #speed of light
sc = 1 #courant constant (c*delta(t)/delta(x))

side = 100
e_initial_module = 100

#defines initial and final E field
e_inicial = [e_initial_module]*side
e_final = [e_initial_module]*side

e = [[]*side]*side
e[0] = e_inicial
e[side-1] = e_final

#defines B field mesh
b = [[]*side]*side

for time in range(side):
    for space in range(side):


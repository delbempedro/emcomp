"""
  PlotField.py

Module that plots the field of the simulation.

Dependencies:
- Main.jl

Since:
- 12/2024

Authors:
- Pedro Calligaris Delbem <pedrodelbem@usp.br>
"""
import numpy as np
import matplotlib.pyplot as plt

# Definir uma grade 2D
x, y = np.meshgrid(np.linspace(-2, 2, 20), np.linspace(-2, 2, 20))

# Intensidade do campo em cada ponto
intensidade = np.sqrt(x**2 + y**2)  # Exemplo: magnitude radial

# Direções do campo vetorial (normalizando x e y)
direcao_x = x / (np.sqrt(x**2 + y**2) + 1e-8)  # Adicionado um pequeno valor para evitar divisão por zero
direcao_y = y / (np.sqrt(x**2 + y**2) + 1e-8)

# Componentes do vetor, escalados pela intensidade
u = intensidade * direcao_x
v = intensidade * direcao_y

# Plotar o campo vetorial
plt.figure(figsize=(8, 8))
plt.quiver(x, y, u, v, intensidade, cmap='viridis', scale=20)  # Colore pela intensidade
plt.colorbar(label='Intensidade')
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Campo Vetorial com Intensidade')
plt.axis('equal')
plt.grid()
plt.show()
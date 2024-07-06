import numpy as np 
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# graphs path 
graphs_path = "graficos/"
DPI = 300

font = {
        'weight' : 'bold',
        'size'   : 16}
plt.rc('text', usetex=True)
plt.rc('text.latex', preamble=r'\usepackage{amsmath}')
plt.rc('font', **font) 


filename = 'saidas/tarefa-A/evolucao-posicoes.dat'
data = np.loadtxt(filename)

params = np.loadtxt("saidas/tarefa-A/parametros.dat")
num_particles = int(params[0])


num_timesteps = data.shape[0] // num_particles

data = data.reshape((num_timesteps, num_particles, -1))

fig, ax = plt.subplots(1, 1, figsize=(5, 5), facecolor="lightgray")
particles, = ax.plot([], [], 'bo', color='black', marker='o', markerfacecolor='white', linestyle='', markersize=15)

plt.grid(which="major", linewidth=0.3)
plt.grid(which="minor", linewidth=0.3)
plt.minorticks_on()

ax.set_xlim(0, 10)
ax.set_ylim(0, 10)

def init():
    particles.set_data([], [])
    return particles,

skip = 1   # Adjust this value to skip more or fewer frames

def animate(i):
    x = data[i * skip, :, 1]
    y = data[i * skip, :, 2]
    particles.set_data(x, y)
    return particles,

ani = animation.FuncAnimation(fig, animate, frames = num_timesteps // skip, init_func=init, blit=True)
ani.save(graphs_path + 'tarefa-A/particle_simulation.gif', writer='imagemagick') # , dpi=DPI)
plt.close()
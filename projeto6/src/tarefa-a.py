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
# 
# plt.grid(which = "major", linewidth = 0.5)
# plt.grid(which = "minor", linewidth = 0.2)
# plt.minorticks_on()
fname_positions = 'saidas/tarefa-A/evolucao-posicoes.dat'
data = np.loadtxt(fname_positions)

params = np.loadtxt("saidas/tarefa-A/parametros.dat")
num_particles = int(params[0])

num_timesteps = data.shape[0] // num_particles

data = data.reshape((num_timesteps, num_particles, -1))

fig, ax = plt.subplots(1, 1, figsize=(8,8), facecolor="lightgray")

colors = plt.cm.jet(np.linspace(0, 1, num_particles))

for i in range(num_particles):
    x = data[:, i, 1]
    y = data[:, i, 2]
    ax.plot(x, y, 'o', markersize=4,markeredgewidth=.3, color='black', markerfacecolor=colors[i], label=f'Particle {i+1}')

plt.grid(which="major", linewidth=0.3)
plt.grid(which="minor", linewidth=0.3)
plt.minorticks_on()

ax.set_xlim(0, 10)
ax.set_ylim(0, 10)

plt.savefig(graphs_path+'tarefa-A/posicoes-finais.png', bbox_inches = 'tight')#  dpi=DPI)
plt.show()
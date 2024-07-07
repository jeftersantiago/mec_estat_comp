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


"""
    PLOTS TAREFA-A
"""

data = np.loadtxt("saidas/tarefa-A/posicoes-iniciais.dat")
params = np.loadtxt("saidas/tarefa-A/parametros.dat")
num_particles = int(params[0])


X = np.linspace(0, 10, data.shape[0])
Y = np.linspace(0, 10, data.shape[0])

fig, ax = plt.subplots(1, 1, figsize=(8, 8), facecolor="lightgray")

plt.xlim(0, 10)
plt.ylim(0, 10)

num_timesteps = data.shape[0] // num_particles

data = data.reshape((num_timesteps, num_particles, -1))

plt.grid(which = "major", linewidth = 0.3)
plt.grid(which = "minor", linewidth = 0.3)
plt.minorticks_on()

colors = plt.cm.jet(np.linspace(0, 1, num_particles))
for i in range(num_particles):
    x = data[:, i, 0]
    y = data[:, i, 1]
    ax.plot(x, y, 'o', markersize=9, color='black', markerfacecolor=colors[i], label=f'Particle {i+1}')

plt.savefig(graphs_path+'tarefa-A/posicoes-iniciais.png', dpi=400, bbox_inches = 'tight')
plt.close()

fname_positions = 'saidas/tarefa-A/evolucao-posicoes.dat'
data = np.loadtxt(fname_positions)

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
# plt.show()
plt.close()

# GIF 
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

def animate(i):
    x = data[i, :, 1]
    y = data[i, :, 2]
    particles.set_data(x, y)
    return particles,

ani = animation.FuncAnimation(fig, animate, frames = num_timesteps, init_func=init, blit=True)
ani.save(graphs_path + 'tarefa-A/evolucao.gif', writer='imagemagick', dpi=DPI)
plt.close()


fname = "saidas/tarefa-A/energia.dat"
data = np.loadtxt(fname)
params = np.loadtxt("saidas/tarefa-A/parametros.dat")

num_particles = int(params[0])

L = params[1]
dt = params[3]

steps = data[:, 0]
E = data[:, 1]

fig , ax =  plt.subplots(1, 1, figsize=(5, 5), facecolor="lightgray")

font = {
        'weight' : 'bold',
        'size'   : 16}
plt.rc('text', usetex=True)
plt.rc('text.latex', preamble=r'\usepackage{amsmath}')
plt.rc('font', **font) 
plt.legend()

ax.plot(steps, E, 'bo-', label=f"$E = T + \\mathcal\\{'U'}$")
ax.set_xlabel("Iteração")
ax.set_ylabel(f"$E$")

ax.grid(which="major", linewidth=0.3)
ax.minorticks_on()
ax.grid(which="minor", linewidth=0.3)
plt.savefig(graphs_path+'tarefa-A/energia.png', bbox_inches = 'tight')#  dpi=DPI)

plt.close()


"""
    PLOTS TAREFA-B
"""

data = np.loadtxt('saidas/tarefa-B/velocidades.dat')
params = np.loadtxt("saidas/tarefa-A/parametros.dat")

num_particles = int(params[0])
dt = params[3]


ignore = 1000 # equilibrio
iterations = data[ignore:, 0]
v_mag = data[ignore:, 1]
vx = data[ignore:, 2]
vy = data[ignore:, 3]

time = iterations * dt
intervals = [(20, 40), (40, 60), (60, 80)]

kT = 0.7
v = np.linspace(0, 3, 500)
vx_vy = np.linspace(-3, 3, 500)

P_v = v / kT * np.exp(-v**2 / (2 * kT))
P_vx =  (0.5/ np.sqrt(kT)) * np.exp(-vx_vy**2 / (2 * kT))
P_vy =  (0.5/ np.sqrt(kT)) * np.exp(-vx_vy**2 / (2 * kT))

fig, axs = plt.subplots(2, 3, figsize=(18, 10), facecolor="lightgray")

for i, (t_start, t_end) in enumerate(intervals):
    mask = (time >= t_start) & (time < t_end)
    v_mag_interval = v_mag[mask]
    vx_interval = vx[mask]
    vy_interval = vy[mask]

    axs[0, i].hist(v_mag_interval, bins=20, density=True, alpha=0.6, color='g', label='$|v|$')
    v_range = np.linspace(0, np.max(v_mag_interval), 500)
    axs[0, i].plot(v, P_v, 'r--', label='Teórica')# $P(v) \\sim \\frac{v^2}{k_B T} \\exp\\left(-\\frac{mv^2}{2k_B T}\\right)$')
    axs[0, i].set_title(f'${t_start}$  à ${t_end}$')
    axs[0, i].set_xlabel('$v$')
    axs[0, i].set_ylabel('$P(v)$')
    axs[0, i].legend()

    axs[1, i].hist(vx_interval, bins=20, density=True, alpha=0.6, label='$v_x$', color='b')
    axs[1, i].hist(vy_interval, bins=20, density=True, alpha=0.6, label='$v_y$', color='r')
        
    axs[1, i].plot(vx_vy, P_vx, 'k--', label='Teórica') #$P(v) \\sim \\frac{1}{\\sqrt{k_B T}} \\exp\\left(-\\frac{mv^2}{2k_B T}\\right)$')
    axs[1, i].set_title(f'$t = {t_start}$ à ${t_end}$')
    axs[1, i].set_xlabel('$v_x$ e $v_y$')
    axs[1, i].set_ylabel('$P(v_x)$ e $P(v_y)$')
    axs[1, i].legend()

plt.tight_layout()
plt.savefig(graphs_path+'tarefa-B/distribuicoes-b.png', bbox_inches = 'tight', dpi=DPI)
plt.close()

filename = 'saidas/tarefa-B/evolucao-posicoes.dat'
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


def animate(i):
    x = data[i, :, 1]
    y = data[i, :, 2]
    particles.set_data(x, y)
    return particles,

ani = animation.FuncAnimation(fig, animate, frames = num_timesteps, init_func=init, blit=True)
ani.save(graphs_path + 'tarefa-B/evolucao.gif', writer='imagemagick', dpi=DPI)
plt.close()
"""
    PLOTS TAREFA-C
"""

data = np.loadtxt('saidas/tarefa-C/velocidades.dat')
params = np.loadtxt("saidas/tarefa-A/parametros.dat")

num_particles = int(params[0])
dt = params[3]

ignore = 1000 # equilibrio
iterations = data[ignore:, 0]
v_mag = data[ignore:, 1]
vx = data[ignore:, 2]
vy = data[ignore:, 3]

# time = iterations * dt
intervals = [(20, 40), (40, 60), (60, 80)]

kT = 0.7
v = np.linspace(0, 3, 500)
vx_vy = np.linspace(-3, 3, 500)

P_v = v / kT * np.exp(-v**2 / (2 * kT))
P_vx =  (0.5/ np.sqrt(kT)) * np.exp(-vx_vy**2 / (2 * kT))
P_vy =  (0.5/ np.sqrt(kT)) * np.exp(-vx_vy**2 / (2 * kT))

fig, axs = plt.subplots(2, 3, figsize=(18, 10), facecolor="lightgray")

for i, (t_start, t_end) in enumerate(intervals):
    mask = (time >= t_start) & (time < t_end)
    v_mag_interval = v_mag[mask]
    vx_interval = vx[mask]
    vy_interval = vy[mask]

    axs[0, i].hist(v_mag_interval, bins=20, density=True, alpha=0.6, color='g', label='$|v|$')
    v_range = np.linspace(0, np.max(v_mag_interval), 500)
    axs[0, i].plot(v, P_v, 'r--', label='Teórica') # $P(v) \\sim \\frac{v^2}{k_B T} \\exp\\left(-\\frac{mv^2}{2k_B T}\\right)$')
    axs[0, i].set_title(f'${t_start}$  à ${t_end}$')
    axs[0, i].set_xlabel('$v$')
    axs[0, i].set_ylabel('$P(v)$')
    axs[0, i].legend()

    axs[1, i].hist(vx_interval, bins=20, density=True, alpha=0.6, label='$v_x$', color='b')
    axs[1, i].hist(vy_interval, bins=20, density=True, alpha=0.6, label='$v_y$', color='r')
        
    axs[1, i].plot(vx_vy, P_vx, 'k--', label='Teórica') # $P(v) \\sim \\frac{1}{\\sqrt{k_B T}} \\exp\\left(-\\frac{mv^2}{2k_B T}\\right)$')
    axs[1, i].set_title(f'$t = {t_start}$ à ${t_end}$')
    axs[1, i].set_xlabel('$v_x$ e $v_y$')
    axs[1, i].set_ylabel('$P(v_x)$ e $P(v_y)$')
    axs[1, i].legend()

plt.tight_layout()
plt.savefig(graphs_path+'tarefa-C/distribuicoes-c.png', bbox_inches = 'tight',  dpi=DPI)

filename = 'saidas/tarefa-C/evolucao-posicoes.dat'
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

def animate(i):
    x = data[i, :, 1]
    y = data[i, :, 2]
    particles.set_data(x, y)
    return particles,

ani = animation.FuncAnimation(fig, animate, frames = num_timesteps , init_func=init, blit=True)
ani.save(graphs_path + 'tarefa-C/evolucao.gif', writer='imagemagick', dpi=DPI)
plt.close()

"""
    PLOTS TAREFA E 
"""

# data = np.loadtxt("saidas/tarefa-E/evolucao-posicoes.dat")
# params = np.loadtxt("saidas/tarefa-E/parametros.dat")
# 
# num_particles = int(params[0])
# L = int(params[1])
# 
# num_particles = int(params[0])
# L = int(params[1])
# 
# num_timesteps = data.shape[0] // num_particles
# 
# data = data.reshape((num_timesteps, num_particles, -1))
# 
# fig, ax = plt.subplots(1, 1, figsize=(5, 5), facecolor="lightgray")
# particles, = ax.plot([], [], 'bo', color='black', marker='o', markerfacecolor='white', linestyle='', markersize=15)
# 
# plt.grid(which="major", linewidth=0.3)
# plt.grid(which="minor", linewidth=0.3)
# plt.minorticks_on()
# 
# ax.set_xlim(0, L)
# ax.set_ylim(0, L)
# 
# def init():
#     particles.set_data([], [])
#     return particles,
# 
# def animate(i):
#     x = data[i,:,2]
#     y = data[i,:,3]
#     particles.set_data(x, y)
#     return particles,
# 
# ani = animation.FuncAnimation(fig, animate, frames = num_timesteps, init_func=init, blit=True)
# ani.save(graphs_path + 'tarefa-E/evolucao.gif', writer='imagemagick', dpi=DPI)
# plt.close()
fig, ax = plt.subplots(1, 3, figsize=(20,7), facecolor="lightgray")
for i in range(1, 4):
    fname_positions = f'saidas/tarefa-E/evolucao-posicoes-{i}.dat'
    data = np.loadtxt(fname_positions)
    params = np.loadtxt("saidas/tarefa-E/parametros.dat")
    num_particles = int(params[0])
    L = params[1]
    dt = params[3]
    
    ax[i-1].grid(which="major", linewidth=0.3)
    ax[i-1].grid(which="minor", linewidth=0.3)
    ax[i-1].minorticks_on()

    num_timesteps = data.shape[0] // num_particles
    data = data.reshape((num_timesteps, num_particles, -1))
    colors = plt.cm.jet(np.linspace(0, 1, num_particles))
    for j in range(num_particles):
        x = data[:, j, 1]
        y = data[:, j, 2]
        ax[i-1].plot(x, y, 'o', markersize=4,markeredgewidth=.3, color='black', markerfacecolor=colors[j], label=f'Particle {j+1}')
    ax[i-1].set_xlim(0, L)
    ax[i-1].set_ylim(0, L)
plt.savefig(graphs_path + f'tarefa-E/posicoes-finais.png', bbox_inches='tight', dpi=DPI)

"""
     Tarefa F 
"""
fig, ax = plt.subplots(1, 3, figsize=(20,7), facecolor="lightgray")
for i in range(1, 4):
    fname_positions = f'saidas/tarefa-F/evolucao-posicoes-{i}.dat'
    data = np.loadtxt(fname_positions)
    params = np.loadtxt("saidas/tarefa-F/parametros.dat")
    num_particles = int(params[0])
    L = params[1]
    dt = params[3]
    
    ax[i-1].grid(which="major", linewidth=0.3)
    ax[i-1].grid(which="minor", linewidth=0.3)
    ax[i-1].minorticks_on()

    num_timesteps = data.shape[0] // num_particles
    data = data.reshape((num_timesteps, num_particles, -1))
    colors = plt.cm.jet(np.linspace(0, 1, num_particles))
    for j in range(num_particles):
        x = data[:, j, 1]
        y = data[:, j, 2]
        ax[i-1].plot(x, y, 'o', markersize=4,markeredgewidth=.3, color='black', markerfacecolor=colors[j], label=f'Particle {j+1}')
    ax[i-1].set_xlim(0, L)
    ax[i-1].set_ylim(0, L)
plt.savefig(graphs_path + f'tarefa-F/posicoes-finais.png', bbox_inches='tight', dpi=DPI)

fname = "saidas/tarefa-F/energia.dat"
data = np.loadtxt(fname)
params = np.loadtxt("saidas/tarefa-F/parametros.dat")

num_particles = int(params[0])
L = params[1]
dt = params[3]
steps = data[:, 0]
E = data[:, 1]

fig , ax =  plt.subplots(1, 1, figsize=(8,8), facecolor="lightgray")

font = {
        'weight' : 'bold',
        'size'   : 16}
plt.rc('text', usetex=True)
plt.rc('text.latex', preamble=r'\usepackage{amsmath}')
plt.rc('font', **font) 

ax.plot(steps * dt, E, '-')
ax.set_xlabel("$t$")
ax.set_ylabel(f"$E$")

ax.grid(which="major", linewidth=0.3)
ax.minorticks_on()
ax.grid(which="minor", linewidth=0.3)
plt.legend()
plt.savefig(graphs_path + f'tarefa-F/energia.png', bbox_inches='tight', dpi=DPI)
plt.show()
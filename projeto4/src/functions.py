import matplotlib.pyplot as plt
import numpy as np



def plot_dla2d(path, theme):
        data = np.loadtxt(path)

        x = data[:, 0]
        y = data[:, 1]
        r = data[:, 2]

        r  = (r - np.min(r)) / (np.max(r) - np.min(r))

        font = {
                'weight' : 'bold',
                'size'   : 16}
        plt.rc('text', usetex=True)
        plt.rc('text.latex', preamble=r'\usepackage{amsmath}')
        plt.rc('font', **font) 

        plt.figure(figsize=(10, 10))
        scatter = plt.scatter(x, y, c=r, cmap=theme,edgecolors='black', linewidths=0.5, s=20, alpha=0.75)

        plt.style.use("default") #'dark_background')
        

        

        plt.gca().set_aspect('equal', adjustable='box')


        cbar = plt.colorbar(scatter, fraction = 0.03)
        cbar.ax.tick_params(labelsize=10)  
        cbar.set_label('Raio normalizado', fontsize=16)  

        return plt


def plot_dla3d(path, theme):
    data = np.loadtxt(path)

    x = data[:, 0]
    y = data[:, 1]
    z = data[:, 2]
    r = data[:, 3]

    # Create a 3D plot
    fig = plt.figure(figsize=(10, 10))
    ax = fig.add_subplot(111, projection='3d')

    font = {
            'weight' : 'bold',
            'size'   : 16}
    plt.rc('text', usetex=True)
    plt.rc('text.latex', preamble=r'\usepackage{amsmath}')
    plt.rc('font', **font) 

    scatter = ax.scatter(x, y, z, c=r, cmap = theme, edgecolors='black', linewidths=0.5, s=20, alpha=0.75)

    # Set the title and axis labels
    ax.set_title('DLA 3D', fontsize = 16)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')

    # Set the aspect ratio and background style
    ax.set_box_aspect([np.ptp(x), np.ptp(y), np.ptp(z)])
    plt.style.use('default') # 'dark_background')


    # Add colorbar
    cbar = plt.colorbar(scatter, fraction=0.03)
    cbar.ax.tick_params(labelsize=10)
    cbar.set_label('Normalized Radius', fontsize=16)
    
    return plt



def linear_reg(r, Nr):
    log_r = np.log(r)
    log_Nr = np.log(Nr)

    # Perform linear regression
    slope, intercept = np.polyfit(log_r, log_Nr, 1)

    # Print the slope (angular coefficient)
    print("Angular coefficient (slope):", slope)
    print("Intercept = ", intercept)
    
    return log_r, slope * log_r + intercept
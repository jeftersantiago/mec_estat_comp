
import matplotlib.pyplot as plt
import numpy as np


def linear_reg(r, Nr):
    log_r = np.log(r)
    log_Nr = np.log(Nr)

    # Perform linear regression
    slope, intercept = np.polyfit(log_r, log_Nr, 1)

    # Print the slope (angular coefficient)
    print("Angular coefficient (slope):", slope)
    print("Intercept = ", intercept)
    
    return log_r, slope * log_r + intercept
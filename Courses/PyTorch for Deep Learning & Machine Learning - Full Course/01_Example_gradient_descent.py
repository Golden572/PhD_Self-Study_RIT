import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Define a sample function: f(x, y) = x^2 + y^2
def f(x, y):
    return 5*x**2 + y**2

# Define its gradient: ∇f = [2x, 2y]
def grad_f(x, y):
    return np.array([10*x, 2*y])

# Set up grid for visualization
x_vals = np.linspace(-10, 10, 40)
y_vals = np.linspace(-10, 10, 40)
X, Y = np.meshgrid(x_vals, y_vals)
Z = f(X, Y)

# Compute gradients at each grid point
U = 2 * X  # d/dx
V = 2 * Y  # d/dy

# Starting point for gradient descent
x0, y0 = -5, -6
path = [(x0, y0)]
step_size = 0.01

# Take 10 steps in the direction of negative gradient
for _ in range(10):
    grad = grad_f(x0, y0)
    x0 -= step_size * grad[0]
    y0 -= step_size * grad[1]
    path.append((x0, y0))

path = np.array(path)
z_path = f(path[:, 0], path[:, 1])

# --- 2D Plot ---
fig2d, ax2d = plt.subplots(figsize=(8, 6))
print('Run Successfully!')

ax2d.contour(X, Y, Z, levels=20)
ax2d.quiver(X, Y, U, V, color='gray', alpha=0.5)
ax2d.plot(path[:, 0], path[:, 1], 'ro-', label='Descent Path')
ax2d.plot(path[0, 0], path[0, 1], color='k', marker='*', markersize=10, label='Initial Point')
ax2d.plot(path[-1, 0], path[-1, 1], color='b', marker='*', markersize=10, label='Final Point')
ax2d.set_title("Moving in Opposite Direction of Gradient (Descent)")
ax2d.set_xlabel("x")
ax2d.set_ylabel("y")
ax2d.legend()
ax2d.grid(True)

# --- 3D Plot ---
fig3d = plt.figure(figsize=(10, 7))
ax3d = fig3d.add_subplot(111, projection='3d')

ax3d.plot_surface(X, Y, Z, cmap='viridis', alpha=0.6)
ax3d.plot(path[:, 0], path[:, 1], z_path, 'r.-', label='Descent Path', linewidth=2, markersize=5)
ax3d.scatter(path[0, 0], path[0, 1], z_path[0], color='k', marker='*', s=100, label='Initial Point')
ax3d.scatter(path[-1, 0], path[-1, 1], z_path[-1], color='b', marker='*', s=100, label='Final Point')

ax3d.set_title("Gradient Descent on 3D Surface")
ax3d.set_xlabel("x")
ax3d.set_ylabel("y")
ax3d.set_zlabel("f(x, y)")
ax3d.legend()

plt.show()

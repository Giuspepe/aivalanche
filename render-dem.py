#1
import numpy as np

def load_dem(file_path):
    """
    Load the DEM file in X, Y, Z ASCII format.
    Skips the header row ("X Y Z").
    Returns arrays of X, Y, Z.
    """
    # Load the data while skipping the first row
    data = np.loadtxt(file_path, skiprows=1)
    x = data[:, 0]  # First column: X values
    y = data[:, 1]  # Second column: Y values
    z = data[:, 2]  # Third column: Z values
    return x, y, z

# Example usage
file_path = "data/SLFPro Avalanches/DEM-pizzo-folcra-avalanche-SWISSALTI3D_0.5_XYZ_CHLV95_LN02_2684_1148.xyz"
x, y, z = load_dem(file_path)
print("Loaded DEM data:", x.shape, y.shape, z.shape)

# 2

import pyvista as pv

# Create a structured grid if X, Y form a grid
grid = pv.StructuredGrid()
grid.points = np.column_stack((x, y, z))
grid.dimensions = (len(np.unique(x)), len(np.unique(y)), 1)  # Adjust based on your grid layout



# 3

# transform latitude (8.541944000) and longitude (46.478333000) to LV95: https://www.swisstopo.admin.ch/de/koordinaten-konvertieren-navref
camera_x = 2684726.785
camera_y = 1148040.781
# altitude from digital elevation map + 1-2 m because the camera is held by a person above the ground
camera_z = 2300


focal_length = 5.1 # in mm?

# angles in degrees
pitch = 0 # assumption
roll = 0 # assumption
yaw = 359.86181640625 # from exif data

# avalanche release point
avalanche_release_x = 2684142.245
avalanche_release_y = 1148650.285
avalanche_release_z = 2600



from scipy.spatial.transform import Rotation as R

# Assuming you already have camera_x, camera_y, camera_z, roll, pitch, yaw, and focal_length
# First, define the camera's position
camera_position = (camera_x, camera_y, camera_z)

# Now we can set up the camera without focal_point, just using the position and forward direction
camera = pv.Camera()
camera.position = camera_position
#camera.view_up = rotation[:, 1]  # Set the 'up' direction based on the Y-axis of the rotation matrix
camera.roll=-45
camera.yaw=-45
camera.azimuth=-45

# Adjust the camera to look towards the `look_at` point (this replaces using a focal_point)
#camera.view_angle = 45  # Optional: Set a specific field of view angle
#camera.parallel_scale = focal_length  # For orthographic projection


# 4

plotter = pv.Plotter()

plotter.add_mesh(grid, cmap="terrain")  # Add your grid mesh with a colormap
# add markers
plotter.add_arrows(np.array([avalanche_release_x, avalanche_release_y, avalanche_release_z + 50]), np.array([0, 0, -10]), mag=5, color='red')
plotter.add_arrows(np.array([camera_x, camera_y, camera_z + 50]), np.array([0, 0, -10]), mag=5, color='green')


plotter.camera = camera  # Apply your custom camera

plotter.show()  # Show the plot
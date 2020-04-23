# Stary Night

## A particle simulation with little stars that are "pushed around" by the mouse.

# Tricky Parts

- There are 3 PVectors in a star: position, velocity, and acceleration. The velocity is the change in position per unit of time, 
 which translates to the increment/decrement in position every unit of time. Simply adding velocity to position every unit of 
 time (in this case every frame in the draw function) will work. Similarly, adding acceleration to velocity will get the job done.
 
 - In Star's checkBoundary function, the sign of the velocity is flipped every time a star hits the border to flip its direction. 
 Notice that the same is done to the acceleration. This is due to the fact that by flipping velocity's sign, the acceleration 
 will have the same sign as the velocity, causing the star to speed up uncontrollably. Therefore, flipping the accelerations sign 
 will keep the star in deceleration/constant velocity.

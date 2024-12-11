println("Importing packages...")
using Plots, LinearAlgebra, Roots

# COMMENTS:
#
# possible pitfalls: non convergence for secant method, division by zero when calculating electric field.
# 
# How to make gif of heatmap of norms? 
#
# Consider plotting magnetic field too?

const eps0   = 8.85e-12     # Permittivity of free space
const c      = 1            # Speed of light
const q      = 1.6e-19      # Charge (electron)
const qpieps = q/(4pi*eps0)
const R      = 1.0          # Radius of circular path (m)
const omega  = 10e-8*c/R       # Angular velocity (rad/s)
const T      = 2pi/omega    # Period of motion
const h      = 1e-6         # for secant method

function particle_position(t)
  x = R * cos(omega * t)
  y = R * sin(omega * t)
  [x, y, 0.0]
end

function particle_velocity(t)
  vx = -R * omega * sin(omega * t)
  vy = R * omega * cos(omega * t)
  [vx, vy, 0.0]
end

function particle_acceleration(t)
  ax = -R * omega^2 * cos(omega * t)
  ay = -R * omega^2 * sin(omega * t)
  [ax, ay, 0.0]
end

"""Solve for retarded time at point r using Secant method."""
function retarded_time(r, t)
    f(t_ret) = begin
        pos = particle_position(t_ret)
        return -t + t_ret + sqrt((r[1] - pos[1])^2 + (r[2] - pos[2])^2) / c
    end 

    precision = T / 1000
    start = t - ((sqrt(r[1]^2 + r[2]^2) + R) / c) - precision
    finish = t
    
    # scipy.optimize.brentq -> find_zero
    t_ret = find_zero(f, (start, finish), Roots.Brent())
    if t_ret >= t 
      println("WRONG TIME")
    end
    t_ret
end

function radius(field_point,particle_position)

  return [particle_position[1] - field_point[1], particle_position[2] - field_point[2], 0.0]

end

"""Find electric field vector at point r at time t."""
function electric_field(r, t)
    t_ret = retarded_time(r, t)
    radius_ret = particle_position(t_ret)
    v_ret = particle_velocity(t_ret)
    a_ret = particle_acceleration(t_ret)
    
    r_ret = radius(r,radius_ret)
    
    u = c*r_ret/norm(r_ret) - v_ret
    u_hat = u/norm(u)
    qpieps*norm(r_ret)/(dot(r_ret,u)^3)*((c^2 - dot(v_ret,v_ret))*u_hat + cross(r_ret,cross(u,a_ret)))
end

"""Calculates electric field at every point on a grid at time t."""
function calculate_field_grid(t, xrange, yrange, npoints)
    x = range(xrange[1], xrange[2], length=npoints)
    y = range(yrange[1], yrange[2], length=npoints)
    
    # Preallocate...
    Ex = zeros(npoints, npoints)
    Ey = zeros(npoints, npoints)
    
    # Calculate field at each point
    for i in 1:npoints, j in 1:npoints
      r = [x[i], y[j], 0.0]
      E = electric_field(r, t)
      Ex[j,i] = E[1]  # columns first for speed.
      Ey[j,i] = E[2]
    end
    
    x, y, Ex, Ey
end

"""Gives plots of electric field, particle movement and particle trajectory."""
function plot_field(t)
    xrange = (-5R, 5R)
    yrange = (-5R, 5R)
    npoints = 25  # Number of grid points. Not too large.
    
    x, y, Ex, Ey = calculate_field_grid(t, xrange, yrange, npoints)
    
    E = @. sqrt(Ex^2 + Ey^2) # normalize 
    Ex ./= E 
    Ey ./= E

    # Create vectors for quiver plot.
    Y = repeat(x, 1, length(y))
    X = repeat(y', length(x), 1)
    
    # Create plot
    p = plot(aspect_ratio=:equal,
        xlim=xrange,
        ylim=yrange,
        title="Electric Field of Moving Charge",
        xlabel="x (m)",
        ylabel="y (m)")
    
    # Plot fields
    quiver!(X[:], Y[:], quiver=(Ex[:], Ey[:]),
        color=:blue,
        alpha=0.6)
    
    # Plot particle position
    r = particle_position(t)
    scatter!([r[1]], [r[2]], 
        color=:red,
        label="Particle",
        markersize=4,
       legend=false)
    
    # Plot particle trajectory
    theta = range(0, 2pi, length=100)
    plot!(R*cos.(theta), R*sin.(theta), 
        color=:black,
        linestyle=:dash,
        label="Trajectory",
       legend=false)
    
    p
end


"""Creates animation for electric field and its norm."""
function animate_field()
    num_frames = 120
    println("Plotting first gif...")
    anim = @animate for t in range(0,2T,length=num_frames)
        plot_field(t)
    end
    println("Saving first gif...")
    gif(anim, "E_field.gif", fps=15)
end

# run code
animate_field()

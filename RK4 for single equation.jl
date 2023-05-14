    y0 = [5] #the initial value of y
    # f is the function defining the differential equation
    f(t, y) = (t .+ y) .* sin.(t .* y)
    # tspan is a tuple (t0, tf) defining the time interval
    t0 = 0
    tf = 2
    # h is the step size
    h = 0.01
    n = Int(round((tf - t0) / h)) # Number of steps
    y = zeros(length(y0), n+1) # Solution vector
    t = collect(range(t0, tf, step=h)) # Time vector
    y[:,1] = y0 # Initial condition
    for i in 1:n
        k1 = f(t[i], y[:,i])
        k2 = f(t[i]+h/2, y[:,i]+(h/2)*k1)
        k3 = f(t[i]+h/2, y[:,i]+(h/2)* k2)
        k4 = f(t[i]+ h, y[:,i]+ h* k3)
        y[:,i+1] = y[:,i]+(h/6)*(k1+ 2*k2+2*k3+k4)
    end
    using Plots
    println(y[:, end])
    plot(t,y[1,:])
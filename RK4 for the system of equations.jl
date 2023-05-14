#the initial values of dependents variables 
y0 = [-1]; 
s0 = [1];
# f is the function defining the differential equation
f1(t, y, s) = sin.(t) .+ cos.(y) .+sin.(s);
f2(t, y, s) = cos.(t) .+sin.(s);
# tspan is a tuple (t0, tf) defining the time interval
t0 = 0;
tf = 20;
# h is the step size
h = 0.2;
n = Int(round((tf - t0) / h)) ;# Number of steps
# Solution vector
y = zeros(length(y0), n+1);
s = zeros(length(s0), n+1);
t = collect(range(t0, tf, step=h)) # Time vector
# Initial conditions
y[:,1] = y0 ;
s[:,1] = s0 ;
for i in 1:n
    k1 = f1(t[i], y[:,i], s[:,i])
    l1 = f2(t[i], y[:,i], s[:,i])
    k2 = f1(t[i]+h/2, y[:,i]+(h/2)*k1, s[:,i]+(h/2)*l1)
    l2 = f2(t[i]+h/2, y[:,i]+(h/2)*k1, s[:,i]+(h/2)*l1)
    k3 = f1(t[i]+h/2, y[:,i]+(h/2)*k2, s[:,i]+(h/2)*l2)
    l3 = f2(t[i]+h/2, y[:,i]+(h/2)*k2, s[:,i]+(h/2)*l2)
    k4 = f1(t[i]+ h, y[:,i]+ h*k3, s[:,i]+ h*l3)
    l4 = f2(t[i]+ h, y[:,i]+ h*k3, s[:,i]+ h*l3)
    y[:,i+1] = y[:,i]+(h/6)*(k1+ 2*k2+2*k3+k4)
    s[:,i+1] = s[:,i]+(h/6)*(l1+ 2*l2+2*l3+l4)
end
using Plots
println(y[:, end],s[:, end])
p1 = plot(t,y[1,:],xlabel="t",ylabel="y",label="f1", xlims=(0, tf),legend=:bottomright)
p2 = plot!(t,s[1,:],label="f2", xlims=(0, tf))
#plot(p1,p2,layout=(1,2))
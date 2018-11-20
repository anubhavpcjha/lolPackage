module lolPackage

greet() = print("Hello World!")
greet2()=print("WHY!")

using Distributions, Expectations, ForwardDiff, LinearAlgebra

function foo(μ = 1.0, σ = 2.0)
    d = Normal(μ, σ)
    E = expectation(d)
    return E(x -> sin(x))
end

function Newtonsroot1(f,f_prime;x0,tol=1e-7,maxiter=1000)
    x_old = x0
    error = Inf
    iter = 1
    while (error > tol || error < -1*tol) && iter <= maxiter
        x_new = x_old-(f(x_old)/f_prime(x_old)) # use the passed in map
        error = x_new - x_old
        x_old = x_new
        iter = iter + 1
    end
     if iter < maxiter+1
        return (root = x_old, normdiff = error, iter = iter) # A named tuple
    else
        return nothing
    end
end
D(f)= x ->ForwardDiff.derivative(f,x)

Newtonsroot1(f;x0,tol=1e-7,maxiter=1000)= Newtonsroot1(f,D(f);x0=x0,tol=tol,maxiter=maxiter)


export foo, Newtonsroot1


end

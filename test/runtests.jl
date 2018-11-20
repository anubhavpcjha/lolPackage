using lolPackage
using Test

@testset "lolPackage.jl" begin
    
    #TEST 1 WITH DERIVATIVES
    f(x)=x^2
    fprime(x)=2*x
    @test Newtonsroot1(f,fprime,x0=1.0)[1] ≈ 0.0 atol=0.00001
    
    f(x)=x^2-16
    fprime(x)=2*x
    @test Newtonsroot1(f,fprime,x0=1.0)[1] ≈ 4.0 atol=0.00001
    
    f(x)=(x-2)^2
    fprime(x)=2*x
    @test Newtonsroot1(f,fprime,x0=1.0)[1] ≈ 4.0 atol=0.00001
    
    #TEST 2 WITHOUT DERIVATIVES
    f(x)=x^2
    
    @test Newtonsroot1(f,x0=1.0)[1] ≈ 0.0 atol=0.00001
    
    f(x)=x^2-16
    @test Newtonsroot1(f,x0=1.0)[1] ≈ 4.0 atol=0.00001
    
    f(x)=(x-2)^2
    @test Newtonsroot1(f,x0=1.0)[1] ≈ 2.0 atol=0.00001
    
    #TEST 3 BIGFLOAT
    f(x)=(x-2)^2
    a=BigFloat(2.0)
    @testset "BigFloat" begin
        @test    Newtonsroot1(f,x0=1.0)[1] ≈ 2.0 atol=0.00001
        @test    Newtonsroot1(f,x0=1.0)[1] ≈ a atol=0.00001
    end
    
    
    #TEST 4 tolerance (Accuracy dependent on tolerance)
    f(x)=4x^3-16x+10
    a=Newtonsroot1(f,x₀=1)[1]
    b=Newtonsroot1(f,x₀=1, tol=0.0001)[1]
    c=Newtonsroot1(f,x₀=1, tol=0.01)[1]
    @test f(a)<f(b)<f(c)

    #TEST 5 Non-Convergence
    #Test non-convergence (return nothing)
    f(x)=2+x^2
    @test Newtonsroot1(f,x₀=0.2)==nothing
    
    #TEST 6 Maxiter
    f(x)=log(x)-20
    a=newtonroot(f,x₀=0.2)[1] #Algorithm needs 17 iterations in this case
    b=newtonroot(f,x₀=0.2,maxiter=5)
    @testset "maxiter" begin
    @test a≈4.851651954097909e8 atol=0.000001 
    @test b==nothing
    end;
    
    
    
    
    
end

# SPDX-License-Identifier: MIT
import NumericalRecipes.Special: gammln
import SpecialFunctions
const SF = SpecialFunctions


@testset "gammln" begin
    function test_gammaln(x)
        if isnan(SF.loggamma(x))
            @test isequal(SF.loggamma(x), gammln(x))
        else
            @test isapprox(SF.loggamma(x), gammln(x))
        end
    end

    @test_throws DomainError gammln(0)
    @test_throws DomainError gammln(+0.0)
    @test_throws DomainError gammln(-0.0)
    @test_throws DomainError gammln(-1)

    test_gammaln(NaN)
    @test_broken Inf === gammln(Inf)

    test_gammaln.(1:100)

    test_gammaln.(rand(eps(0.0):eps():2.0^-21,  10))
    test_gammaln.(rand( 2.0^-21:eps():2.0,      10))
    test_gammaln.(rand(     2.0:eps():8.0,      10))
    test_gammaln.(rand(     8.0:2.0^58,         10))
    test_gammaln.(rand(  2.0^58:1e300:1e308,    10))
end

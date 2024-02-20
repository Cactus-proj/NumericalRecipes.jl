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

    @test_throws "bad arg in gammln" gammln(0)
    @test_throws "bad arg in gammln" gammln(+0.0)
    @test_throws "bad arg in gammln" gammln(-0.0)
    @test_throws "bad arg in gammln" gammln(-1)
    
    test_gammaln(NaN)
    test_gammaln.(1:10)
end

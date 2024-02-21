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


function rand_common(times=10^3)
    F64_1EM3 = 0x3f50624dd2f1a9fc
    F64_1EP3 = 0x408f400000000000
    reinterpret(Float64, rand(F64_1EM3:F64_1EP3,times))
end
function rand_subnormal(times=10^3)
    F64_MIN_SUBNORMAL = 0x00000000_00000001
    F64_MAX_SUBNORMAL = 0x000fffff_ffffffff
    reinterpret(Float64, rand(F64_MIN_SUBNORMAL:F64_MAX_SUBNORMAL,times))
end
function rand_normal(times=10^3)
    F64_MIN_NORMAL = 0x00100000_00000000
    F64_MAX_NORMAL = 0x7fefffff_ffffffff
    reinterpret(Float64, rand(F64_MIN_NORMAL:F64_MAX_NORMAL,times))
end
function rand_f64(times=10^3)
    F64_MAX_NORMAL = 0x7fefffff_ffffffff
    reinterpret(Float64, rand(0x1:F64_MAX_NORMAL,times))
end
function rand_floatmax(times=10^3)
    rand(Float64, times) * floatmax(Float64)
end

# using FunctionAccuracyTests
# Need FunctionAccuracyTests
function max_ulp()
    x = [
        1:10^4...,
        rand_common(10^4)...,
        rand_subnormal(10^4)...,
        rand_normal(10^4)...,
        rand_f64(10^4)...,
        rand_floatmax(10^4)...,
    ]

    fmap = Dict([ gammln => SF.loggamma ])
    # (0.0, floatmax(Float64))
    test_acc(fmap, x)

    # [1e-3, 1e3]
    test_acc(fmap, rand_common(10^5))
end

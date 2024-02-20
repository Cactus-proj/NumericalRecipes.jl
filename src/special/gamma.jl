#

"""
https://www.mrob.com/pub/ries/lanczos-gamma.html
"""
const _GAMMALN_COF = Float64[
    57.1562356658629235,       -59.5979603554754912,
    14.1360979747417471,       -0.491913816097620199,       0.339946499848118887e-4,
    0.465236289270485756e-4,   -0.983744753048795646e-4,    0.158088703224912494e-3,
   -0.210264441724104883e-3,    0.217439618115212643e-3,   -0.164318106536763890e-3,
    0.844182239838527433e-4,   -0.261908384015814087e-4,    0.368991826595316234e-5
]

"""
    gammln(x)

Compute `ln( Γ(x) )`, for `x > 0`,
Throw `DomainError` when `x <= 0`.

Ref: [NR3-6.1.5]
"""
function gammln(x)
    if x <= 0
        throw(DomainError("bad arg in gammln, x > 0"))
    end

    y = x
    tmp = x + 671/128
    tmp = (x + 0.5) * log(tmp) - tmp
    ser = 0.999999999999997092
    
    for j = 1:14
        y += 1
        # XXX: 也许应该逆向求和，小项在前
        ser += _GAMMALN_COF[j] / y
    end

    return tmp + log(2.5066282746310005 * ser / x)
end

! We know that F(w) = S*g / (pi * (w-wm)^2 + g^2)
!
! We consifer the inverse F(w)^-1 = (pi * (w-wm)^2 + g^2) / (S*g)
!
! ##########
! 1st idea
! ##########
!
! Let's consider x = (w - wm) / wm
! So w = wm * (1+x)
! Then F(x)^-1 = x^2 * pi*wm^2/(s*g) + pi*g/S
! 
! Let's define a2 = pi*wm^2/(s*g)
!          and a0 = pi*g / S
!
! So we have F(x)^-1 = a2 * x^2 + a0
!
! -> E(a2, a0)  = sum[i=1..N] Wi * (a2*xi^2 + a0 - yi)^2
!
! derivation on 'a2' and on 'a0' must be = 0 so we have the system:
!    dE(a2, a0)/da2 = sum[i=1..N] Wi * 2 * (a2*xi^2 + a0 - yi) * xi^2 = 0
!    dE(a2, a0)/da0 = sum[i=1..N] Wi * 2 * (a2*xi^2 + a0 - yi) * xi   = 0
!
! So we have:
!    a2 * sum[i=1..N] (Wi * xi^4) + a0 * sum[i=1..N] (Wi Xi^2) = sum[i=1..N] (Wi * yi * xi^2)
!    a2 * sum[i=1..N] (Wi * xi^2) + a0 * sum[i=1..N] (Wi)      = sum[i=1..N] (Wi * yi)
!
! If we multiply both equation by 1/N to get the averages <x> = sum[i=1..N] x/N
! And we get:
!    a2 * <x^4> + a0 * <x^2> = <y*x^2>
!    a2 * <x^2> + a0 * <1>   = <y>        /!\ Be carefull: here we consider that Wi is always 1, but if it is not the case, this is false.
!
! We can form the matrix:
!    | <x^4>   <x^2> |  *  | a2 |  =  | <yx^2> |
!    | <x^2>   <1>   |     | a0 |     | <y>    |
!
! So we can determine that:
!   a0 = <yx^2>   - <y><x^4>  / (<x^2>^2 - <x^4><1>)
!   a2 = <y><x^2> - <yx^2><1> / (<x^2>^2 - <x^4><1>)
!
! We need: <yx^2>, <y>, <x^4>, <x^2>, <1>    (<1> is for Wi always = 1)
!
! ##########
! 2nd idea
! ##########
!
!   x = w - <w> / sqrt( <w^2> - <w>^2 )
!     = w - <w> / sigma
!
! With <w> = sum[i=1..N] wi/N
!
!   x*sigma = w - <w>    ->    w = <w> + x * sigma
!
! So we have
!    F(x)^-1 =   pi / (S*g) * (sigma^2 * x^2 + 2*sigma*x*<w> + <w>^2)
!            - 2*pi / (S*g) * (sigma*x + <w>)
!            +   pi / (S*g) * (wm^2 + sigma^2)
!
program smooth
    implicit none
    integer :: N = 0
    integer :: i, io
    real :: a0, a1, a2
    real :: w_av, w2_av, sigma
    real :: x_av, x2_av, x3_av, x4_av
    real :: y_av, yx_av, yx2_av
    real :: WEIGHT_av
    real :: tmp, res, pi = 3.1415
    real :: wm, gamma, S
    real, dimension(1000):: fexp, w, w2, x, x2, x3, x4, y, yx, yx2, WEIGHT, WEIGHT1
    real :: pressure

    open (unit = 10, file = "data/spectre_5.txt")   ! openiing file
    pressure = 15.0                                 ! associated pressure

! __________________________________________________
! READ FILE

    do                                              ! Counting line number
        READ(10,*,iostat=io) tmp
        if (io /= 0) then
            exit
        else
            N = N+1
        end if
    end do

    rewind(10)
    do i=1,N                                        ! Reading lines
        READ(10,*) fexp(i)
    end do

! __________________________________________________
! COMPUTE


    do i=1,N                                        ! weight functions
        WEIGHT1(i) = 1
        WEIGHT(i) = fexp(i) * fexp(i)
    end do


    do i = 1,N                                      ! w range
        w(i) = 2280 + 0.01 * (i-1)
        w2(i) = w(i) * w(i)
    end do


    call average (w, WEIGHT1, N, res)               ! w averages
    w_av = res
    call average (w2, WEIGHT1, N, res)
    w2_av = res

    
    sigma = sqrt(w2_av - w_av*w_av)                 ! sigma

    
    do i = 1,N                                      ! x and y elements
        x(i) = (w(i) - w_av) / sigma
        x2(i) = x(i) * x(i)
        x3(i) = x2(i) * x(i)
        x4(i) = x3(i) * x(i)
        y(i) = 1/fexp(i)
        yx(i) = x(i) * y(i)
        yx2(i) = yx(i) * x(i)
    end do
    
                                    
    call average (x, WEIGHT, N, res)                ! x and y averages
    x_av = res
    call average (x2, WEIGHT, N, res)
    x2_av = res
    call average (x3, WEIGHT, N, res)
    x3_av = res
    call average (x4, WEIGHT, N, res)
    x4_av = res
    call average (y, WEIGHT, N, res)
    y_av = res
    print *, "<y>=", y_av
    call average (yx, WEIGHT, N, res)
    yx_av = res
    call average (yx2, WEIGHT, N, res)
    yx2_av = res


    call average (WEIGHT1, WEIGHT, N, res)         ! weight average
    WEIGHT_av = res

    denominator =   WEIGHT_av   * x2_av     * x4_av     &
                +   2*x_av      * x2_av     * x3_av     &
                -   x2_av       * x2_av     * x2_av     &
                -   WEIGHT_av   * x3_av     * x3_av     &
                -   x_av        * x_av      * x4_av     &

    
    a0 = (&                                             ! computing a0
            y_av        * x2_av     * x4_av     &
        +   yx_av       * x3_av     * x2_av     &
        +   x_av        * x3_av     * yx2_av    &
        -   yx2_av      * x2_av     * x2_av     &
        -   y_av        * x3_av     * x3_av     &
        -   x_av        * yx_av     * x4_av     &
        ) / denominator

    a1 = (&                                             ! computing a1
            WEIGHT_av   * yx_av     * x4_av     &
        +   x2_av       * x3_av     * y_av      &
        +   x_av        * x2_av     * yx2_av    &
        -   x2_av       * x2_av     * yx_av     &
        -   x_av        * x4_av     * y_av      &
        -   WEIGHT_av   * x3_av     * yx2_av    &
        ) / denominator

    a2 = (&                                             ! computing a2
            WEIGHT_av   * x2_av     * yx2_av    &
        +   x_av        * x3_av     * y_av      &
        +   x_av        * x2_av     * yx_av     &
        -   x2_av       * x2_av     * y_av      &
        -   x_av        * x_av      * yx2_av    &  
        -   WEIGHT_av   * x3_av     * yx_av     &
        ) / denominator

    wm = w_av - sigma * a1 / (2 * a2)

    gamma = sigma * sqrt(a0 / a2 - a1 * a1 / 4 / a2 / a2)

    S = pi * sigma / (sqrt(a0 * a2 - a1 * a1 / 4))


! __________________________________________________
! Print results

    do i = 1,N
        !print *, i, " | w(i)=", w(i), " | fexp(i)=", fexp(i)
    end do

    print *, "sigma=", sigma, "<w>=", w_av, "<w2>=", w2_av
    print *, "<x>=", x_av, "<x2>=", x2_av, "<x3>=", x3_av, "<x4>=", x4_av
    print *, "<y>=", y_av, "<yx>=", yx_av, "<yx2>=", yx2_av
    print *, "a0=", a0, " a1=", a1, "a2=", a2
    print *, "wm=", wm, " gamma=", gamma, " S=", S

    call plot(w, fexp, N, wm, gamma, S, pressure)

end program smooth

subroutine average(x, weight, N, res)
    implicit none
    real :: res
    integer :: N, i
    real, dimension(N) :: x, weight

    res = 0
    do i = 1,N
        res = res + x(i) * weight(i)
    end do

    res = res / float(N)

end subroutine average

subroutine plot(x, y, N, wm, gamma, S, pressure)
    implicit none
    real, dimension(N) :: x
    real, dimension(N) :: y
    real :: wm, gamma, S
    integer :: N
    integer :: i
    integer :: fu
    real :: pressure

    open (action='write', file="results/plot.plt", newunit=fu, status='replace')

    do i = 1, N
        write (fu, *) x(i), y(i)
    end do

    close (fu)

    
    open (action='write', file="results/res.txt", newunit=fu, status='replace')
    write (fu, *) wm, gamma, S, pressure
    close (fu)

    call execute_command_line('python3 plot_spectra.py')
end subroutine plot


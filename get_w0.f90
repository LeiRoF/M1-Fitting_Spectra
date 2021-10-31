program linreg
    implicit none
    real :: a=0, b, res, p_av, w_av
    integer :: i, N = 5
    real, dimension(5) :: w, p, weight

    w = [2282.64526, 2282.93457, 2283.36963, 2283.94995, 2284.68140]
    p = [1.0, 3.0, 6.0, 10.0, 15.0]
    weight = [1.0, 1.0, 1.0, 1.0, 1.0]

    call average(p, weight, N, res)
    p_av = res

    call average(w, weight, N, res)
    w_av = res

    do i=1,5
        a = a + (p(i) - p_av) * (w(i) - w_av)
    end do
    a = a / (p(i) - p_av) / (p(i) - p_av)

    b = w_av - a * p_av

    print *, "Y = ", a, " * x + ", b

    call plot(p, w, N, a, b)

end program linreg

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


subroutine plot(x, y, N, a, b)
    implicit none
    real, dimension(N) :: x
    real, dimension(N) :: y
    integer :: N
    integer :: i
    integer :: fu
    real :: a, b

    open (action='write', file="results/w(p)_exp.plt", newunit=fu, status='replace')

    do i = 1, N
        write (fu, *) x(i), y(i)
    end do

    close (fu)

    open (action='write', file="results/w(p)_theor.txt", newunit=fu, status='replace')

    write (fu, *) a, b

    close (fu)

    call execute_command_line('python plot_wp.py')
end subroutine plot


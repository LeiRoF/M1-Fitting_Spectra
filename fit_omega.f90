program linreg
    implicit none
    real :: a=0, b
    real :: sum_p = 0, sum_p2 = 0, sum_pw = 0, sum_w = 0, sum_w2 = 0
    integer :: i, N = 5
    real, dimension(5) :: w, p

    
    p = [1.0, 3.0, 6.0, 10.0, 15.0]

    open (unit = 10, file = "data/omega.txt")
    do i=1,N
        READ(10,*) w(i)
    end do

    do i=1,N
        sum_p  = sum_p + p(i)
        sum_p2 = sum_p2 + p(i) * p(i)
        sum_pw = sum_pw + p(i) * w(i)
        sum_w  = sum_w + w(i)                                     
        sum_w2 = sum_w2 + w(i) * w(i)                                  
    end do

    a = ( N*sum_pw - sum_p*sum_w ) / &
        ( N*sum_p2 - sum_p*sum_p )

    b = ( sum_w*sum_p2 - sum_p*sum_pw ) / &
        ( N*sum_p2     - sum_p*sum_p  )

    print *, "y = ", a, " * x + ", b

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

    call execute_command_line('python plot_omega.py')
end subroutine plot


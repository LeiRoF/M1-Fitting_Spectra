program linreg
    implicit none
    real :: a1=0, a0
    real :: sum_p = 0, sum_p2 = 0, sum_pw = 0, sum_w = 0, sum_w2 = 0
    integer :: i, N = 5
    real, dimension(5) :: w, p

    p = [1.0, 3.0, 6.0, 10.0, 15.0]                 ! Evaluated pressures

    open (unit = 10, file = "data/omega.txt")       ! Reading omega data file
    do i=1,N
        READ(10,*) w(i)
    end do

    do i=1,N                                        ! computing w and p sums (unlike the mathematical explanation, I use sums here and not averages, which reduces the number of lines of code)
        sum_p  = sum_p + p(i)
        sum_p2 = sum_p2 + p(i) * p(i)
        sum_pw = sum_pw + p(i) * w(i)
        sum_w  = sum_w + w(i)                                     
        sum_w2 = sum_w2 + w(i) * w(i)                                  
    end do

    a1 = ( N*sum_pw - sum_p*sum_w ) / &             ! computing a1
        ( N*sum_p2 - sum_p*sum_p )

    a0 = ( sum_w*sum_p2 - sum_p*sum_pw ) / &        ! computing a0
        ( N*sum_p2     - sum_p*sum_p  )

    print *, "y = ", a1, " * x + ", a0              ! Printing results

    call plot(p, w, N, a1, a0)                      ! Saving results and call python script to plot them

end program linreg

subroutine plot(x, y, N, a1, a0)
    implicit none
    real, dimension(N) :: x
    real, dimension(N) :: y
    integer :: N
    integer :: i
    integer :: fu
    real :: a1, a0

    open (action='write', file="results/w(p)_exp.plt", newunit=fu, status='replace')

    do i = 1, N                                     ! Writing a file containing initial data (but with both coordinates)
        write (fu, *) x(i), y(i)
    end do

    close (fu)

    open (action='write', file="results/w(p)_theor.txt", newunit=fu, status='replace')

    write (fu, *) a1, a0                            ! Writing a file containing fitted line

    close (fu)

    call execute_command_line('python3 plot_omega.py')  ! Call python script
end subroutine plot


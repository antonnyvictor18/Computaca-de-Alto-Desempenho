subroutine matrix_vector_produto(A, x, b, n, m)
    implicit none
    integer :: n, m, i, j
    double precision, intent(in) :: A(n,m), x(m)
    double precision, intent(out) :: b(n)
    b = 0.0
    do i = 1, n
        do j = 1, m
            b(i) = b(i) + A(i,j) * x(j)
        end do
    end do
    end subroutine
    
subroutine matrix_vector_produto_invertido(A, x, b, n, m)
    implicit none
    integer :: n, m, i, j
    double precision, intent(in) :: A(n,m), x(m)
    double precision, intent(out) :: b(n)
    b = 0.0
    do j = 1, m
        do i = 1, n
            b(i) = b(i) + A(i,j) * x(j)
        end do
    end do
    end subroutine


program main
    implicit none
    integer, parameter :: n_max = 10000, m_max = 10000
    integer :: k, n, m, i
    real*8, dimension(:,:), allocatable :: A
    real*8, dimension(:), allocatable :: x, b
    real*8 :: start, end, cpu_time_used1, cpu_time_used2
    character(len=20) :: file_name
        
    call srand(time())
        
    file_name = "resultados.txt"
    open(unit=10, file=file_name, status="replace", action="write")
          
    do k = 1, 10
        n = k * n_max / 10
        m = k * m_max / 10
          
        allocate(A(n, m))
        if (.not. allocated(A)) then
            write(*,*) "Erro ao alocar memória para A!"
            return
        end if

        allocate(x(m))
        if (.not. allocated(x)) then
            write(*,*) "Erro ao alocar memória para x!"
            deallocate(A)
            return
        end if

        if (.not. allocated(b(m))  ) then
            write(*,*) "Erro ao alocar memória para b!"
            deallocate(A)
            deallocate(x)
            return
        end if    

    end do  
    close(10)
end program
      
    
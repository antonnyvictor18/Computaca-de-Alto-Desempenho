subroutine matrix_vector_produto(A, x, b,n)
    implicit none
    integer :: n, i, j
    double precision, intent(in) :: A(n,n), x(n)
    double precision, intent(out) :: b(n)
    do i = 1, n
        do j = 1, n
            b(i) = b(i) + A(i,j) * x(j)
        end do
    end do
    end subroutine
    
subroutine matrix_vector_produto_invertido(A, x, b, n)
    implicit none
    integer :: n, i, j
    double precision, intent(in) :: A(n,n), x(n)
    double precision, intent(out) :: b(n)
    do j = 1, n
        do i = 1, n
            b(i) = b(i) + A(i,j) * x(j)
        end do
    end do
    end subroutine


    program main
        implicit none
        integer, parameter :: n_max = 10000
        integer :: k, n, i, j
        real :: numero_aleatorio
        double precision, dimension(:,:), allocatable :: A
        double precision, dimension(:), allocatable :: x, b
        
        double precision :: start_time, end_time, cpu_time_used1, cpu_time_used2
        character(len=100) :: file_name
            
        file_name = "Resultados/resultados_Fortran.txt"
        open(unit=10, file=file_name, status="replace", action="write")
              
        do k = 1, 10
            
            n = k * n_max / 10
              
            allocate(A(n, n))
            if (.not. allocated(A)) then
                write(*,*) "Erro ao alocar memória para A!"
                stop
            end if
    
            allocate(x(n))
            if (.not. allocated(x)) then
                write(*,*) "Erro ao alocar memória para x!"
                deallocate(A)
                stop
            end if
    
            allocate(b(n))
            if (.not. allocated(b)  ) then
                write(*,*) "Erro ao alocar memória para b!"
                deallocate(A)
                deallocate(x)
                stop
            end if    
    
            do i = 1, n
                do j = 1, n
                    call random_number(numero_aleatorio)
                    A(i, j) = (numero_aleatorio / n_max) * 10.0 - 5.0
                end do
                b(i) = 0.0
                call random_number(numero_aleatorio)
                x(i) = numero_aleatorio/ n_max
            end do
            
            
            ! Loop aninhado padrão: i, j
            call cpu_time(start_time)
            call matrix_vector_produto(A, x, b, n)
            call cpu_time(end_time)
            cpu_time_used1 = end_time - start_time
            write(*,*) n,"x",n,": Tempo de execução aninhado (i,j): ", cpu_time_used1, " segundos"
            
            ! Loop aninhado invertido: j, i
            call cpu_time(start_time)
            call matrix_vector_produto_invertido(A, x, b,n)
            call cpu_time(end_time)
            cpu_time_used2 = end_time - start_time
            write(*,*) n,"x",n,": Tempo de execução aninhado (i,j): ", cpu_time_used2, " segundos"
            write(*,*)

            ! Escrever os valores no arquivo
            write(10, '(I0,"x",I0," ",I0," ",F0.3," ",F0.3)') n, n, k, cpu_time_used1, cpu_time_used2

            deallocate(A)
            deallocate(x)
            deallocate(b)
        end do
        close(10)
end program
      






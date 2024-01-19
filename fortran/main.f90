program main_program
    use cpf_module

    implicit none
    character(len=:), allocatable :: t0, t1, t2, t3

    t0 = reter_numeros('test', 2)
    t1 = reter_numeros('test123', 2)
    t2 = reter_numeros('test123', 3)
    t3 = reter_numeros('test123', 4)

    write(*,*) '   reter_numeros("test", 2)  ->  "', t0, '"'
    write(*,*) 'reter_numeros("test123", 2)  ->  "', t1, '"'
    write(*,*) 'reter_numeros("test123", 3)  ->  "', t2, '"'
    write(*,*) 'reter_numeros("test123", 4)  ->  "', t3, '"'

end program main_program  
program main_program
    use cpf_module

    implicit none
    character(len=:), allocatable :: rn_result
    integer, dimension(2) :: cd_result
    integer :: vf_result

    rn_result = reter_numeros('test', 2)
    write(*, '(A,A,A)') &
        '       reter_numeros("test", 2)  ->  "', rn_result, '"'

    rn_result = reter_numeros('test123', 2)
    write(*, '(A,A,A)') &
        '    reter_numeros("test123", 2)  ->  "', rn_result, '"'

    rn_result = reter_numeros('test123', 3)
    write(*, '(A,A,A)') &
        '    reter_numeros("test123", 3)  ->  "', rn_result, '"'

    rn_result = reter_numeros('test123', 4)
    write(*, '(A,A,A)') &
        '    reter_numeros("test123", 4)  ->  "', rn_result, '"'
    write(*,*) ''


    cd_result = calcular_digitos('test123')
    write(*, '(A,I0,A,I0,A)') &
        '    calcular_digitos("test123")  ->  [ ', &
            cd_result(1), ', ', cd_result(2), ' ]'

    cd_result = calcular_digitos('987.654.321')
    write(*, '(A,I0,A,I0,A)') &
        'calcular_digitos("987.654.321")  ->  [ ', &
            cd_result(1), ', ', cd_result(2), ' ]'

    cd_result = calcular_digitos('111.444.777')
    write(*, '(A,I0,A,I0,A)') &
        'calcular_digitos("111.444.777")  ->  [ ', &
            cd_result(1), ', ', cd_result(2), ' ]'
    write(*,*) ''


    vf_result = verificar('0')
    write(*, '(A,I0,A)') &
        '                 verificar("0")  ->  ', vf_result
    
    vf_result = verificar('19291')
    write(*, '(A,I0,A)') &
        '             verificar("19291")  ->  ', vf_result
    
    vf_result = verificar('12359')
    write(*, '(A,I0,A)') &
        '             verificar("12359")  ->  ', vf_result
    
    vf_result = verificar('11144477735')
    write(*, '(A,I0,A)') &
        '       verificar("11144477735")  ->  ', vf_result

end program main_program  

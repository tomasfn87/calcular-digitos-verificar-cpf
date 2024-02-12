module cpf_module
    implicit none

contains

    function reter_numeros(text, n) result(only_nums)
        character(len=*), intent(in) :: text
        integer, intent(in) :: n

        character(len=:), allocatable :: only_nums
        integer :: i, count

        allocate(character(n) :: only_nums)
        only_nums = repeat(' ', n)

        count = 0
        do i = 1, len(text)
            if (text(i:i) >= '0' .and. text(i:i) <= '9') then
                count = count + 1
                only_nums(count:count) = text(i:i)
            end if
            if (count == n) exit
        end do

        if (count == 0) then
            only_nums = ''
            return
        end if

        if (count < n) then
            only_nums = repeat('0', n - count) // trim(only_nums)
        end if
    end function reter_numeros

    function verificar(cpf) result(validez)
        character(len=*), intent(in) :: cpf

        integer, dimension(2) :: digitos_calculados
        integer, dimension(2) :: digitos_recebidos
        character(len=:), allocatable :: nums_cpf
        integer :: i, integer_value, validez
        
        digitos_recebidos = [ 0, 0 ]
        nums_cpf = reter_numeros(cpf, 11)
        read(nums_cpf(10:10), *) integer_value
        digitos_recebidos(1) = integer_value
        read(nums_cpf(11:11), *) integer_value
        digitos_recebidos(2) = integer_value
        
        digitos_calculados = calcular_digitos(nums_cpf(1:9))
        
        validez = 1
        do i = 1, 2, 1
            if (digitos_calculados(i) /= digitos_recebidos(i)) then
                validez = 0
            end if
        end do
    end function verificar

    function calcular_digitos(cpf) result(digitos_verificadores)
        character(len=*), intent(in) :: cpf

        integer, dimension(2) :: digitos_verificadores
        character(len=:), allocatable :: nums_cpf
        character(len=1) :: char

        write(*,*) '     (from calcular_digitos) cpf  ->  "', cpf, '"'
        nums_cpf = reter_numeros(cpf, 9)
        write(*,*) '(from calcular_digitos) nums_cpf  ->  "', nums_cpf, '"'

        digitos_verificadores = [ 0, 0 ]
        digitos_verificadores(1) = calcular_digito_verificador(nums_cpf)
        write(*, '(A,I0,A,I0,A)') &
            '            digitos_verificadores  ->  [ ', &
            digitos_verificadores(1), ', ', digitos_verificadores(2), ' ]'

        write(char, '(I0)') digitos_verificadores(1)
        nums_cpf = nums_cpf // char
        write(*,*) '(from calcular_digitos) nums_cpf  ->  "', nums_cpf, '"'

        digitos_verificadores(2) = calcular_digito_verificador(nums_cpf)
    end function calcular_digitos

    function calcular_digito_verificador(nums_cpf) result(digito_verificador)
        character(len=*), intent(in) :: nums_cpf

        integer :: digito_verificador, sum, factor, remainder
        integer :: integer_value, i

        digito_verificador = 0
        factor = len(nums_cpf) + 1
        sum = 0

        do i = 1, len(nums_cpf), 1
            read(nums_cpf(i:i), *) integer_value
            sum = sum + (factor * integer_value)
            factor = factor - 1
        end do

        remainder = MOD(sum, 11)
        if (remainder > 1) then
            digito_verificador = 11 - remainder
        end if
    end function

end module cpf_module
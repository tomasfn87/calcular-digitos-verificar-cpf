module cpf_module
    implicit none

    character(len=14) :: cpf_completo
    character(len=11) :: cpf

contains

    function reter_numeros(text, n) result(only_nums)
        character(len=*), intent(in) :: text
        character(len=:), allocatable :: only_nums
        integer, intent(in) :: n
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

end module cpf_module
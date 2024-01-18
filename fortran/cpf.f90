module cpf_module
    implicit none

    character(len=14) :: cpf_completo
    character(len=11) :: cpf

contains

    subroutine hello_world()
        write(*,*) 'Hello, World! CPF:', trim(cpf_completo)
    end subroutine hello_world

end module cpf_module
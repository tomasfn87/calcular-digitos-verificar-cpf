#!/bin/bash

toGreen () { gawk -v text="$1" 'BEGIN {
    printf "%s", "\033[1;32m" text "\033[0m" }'
}

toRed () { gawk -v text="$1" 'BEGIN {
    printf "%s", "\033[1;31m" text "\033[0m" }'
}

if [ -z "$1" ]; then
    echo "`toRed ERRO`: informe um número de CPF.";
    exit 3; fi;

VALIDADE_CPF=`python3 /usr/local/lib/calcular-digitos-verificar-cpf/verificar_cpf.py "$1"`;

if [ "$VALIDADE_CPF" == 2 ]; then
    echo "`toRed ERRO`: informe um número de CPF.";
    exit 2;
elif [ "$VALIDADE_CPF" == 0 ]; then
    echo "CPF `toGreen válido`";
    exit 0; fi;

echo "CPF `toRed inválido`";
exit 1;

#!/bin/bash

toRed() { gawk -v text="$1" 'BEGIN {
    printf "%s", "\033[1;31m" text "\033[0m" }'
}

if [ -z "$1" ]; then
    echo "`toRed ERRO`: informe um número de CPF.";
    exit 1; fi;

CALCULO_CPF=`python3 /usr/local/lib/calcular-digitos-verificar-cpf/calcular_digitos_cpf.py "$1"`;

if [ "$CALCULO_CPF" == 1 ]; then
    echo "`toRed ERRO`: informe um número de CPF.";
    exit 2; fi;

echo "$CALCULO_CPF";
exit 0;

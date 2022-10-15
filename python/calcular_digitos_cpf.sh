#!/bin/bash

toRed () { gawk -v text=$1 'BEGIN {
    printf "%s", "\033[1;31m" text "\033[0m" }'
}

COMPRIMENTO_CPF=$(python3 /usr/local/lib/calcular-digitos-verificar-cpf/verificar_comprimento_cpf.py $1);

if [ $COMPRIMENTO_CPF == 1 ];
then
    echo "$(toRed ERRO): número de CPF deve possuir 9 dígitos";
    exit 1;
fi;

python3 /usr/local/lib/calcular-digitos-verificar-cpf/calcular_digitos_cpf.py $1;
exit 0;

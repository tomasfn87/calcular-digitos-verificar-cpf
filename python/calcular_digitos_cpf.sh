#!/bin/bash

toRed () { gawk -v text=$1 'BEGIN {
    printf "%s", "\033[1;31m" text "\033[0m" }'
}

python3 /usr/local/lib/calcular-digitos-verificar-cpf/calcular_digitos_cpf.py $1;
exit 0;

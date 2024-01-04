Object subclass: CPF [
    | numeroCompleto numero |

    CPF >> initialize [
        numeroCompleto := ''.
        numero := ''
    ]

    CPF >> setNumeroCompleto: newNumeroCompleto [
        numeroCompleto := newNumeroCompleto
    ]

    CPF >> setNumero: newNumero [
        numero := newNumero
    ]

    CPF >> getNumero [
        ^ numero
    ]

    CPF >> getNumeroCompleto [
        ^ numeroCompleto
    ]

    CPF >> reterNumeros: texto quantia: n [
        | onlyNumbers paddedNumbers |

        onlyNumbers := texto copyReplacingAllRegex: '\D' with: ''.
    
        paddedNumbers := onlyNumbers.
        [ paddedNumbers size < n ]
            whileTrue: [
                paddedNumbers := '0', paddedNumbers
            ].

        ( paddedNumbers size > n )
            ifTrue: [
                paddedNumbers := paddedNumbers copyFrom: 1 to: n
            ].

        ^ paddedNumbers
    ]

    CPF >> calcularDigitos [
        | dvs digits factor i digitArray sum mod |

        dvs := #(0 0).

        digits := self reterNumeros: numero quantia: 9.
        factor := digits size + 1.
        i := 1.
        sum := 0.
        digitArray := Array new: digits size + 1.
        [ i <= digits size ]
            whileTrue: [
                digitArray at: i put: (digits copyFrom: i to: i).
                sum := sum + ((digitArray at: i) asInteger * factor).
                factor := factor - 1.
                i := i + 1
            ].

        mod := sum \\ 11.
        ( mod > 1 )
            ifTrue: [
                dvs at: 1 put: 11 - mod
            ].

        digits := digits, (dvs at: 1) asString.
        i := 1.
        sum := 0.
        factor := digits size + 1.
        [ i <= digits size ]
            whileTrue: [
                digitArray at: i put: (digits copyFrom: i to: i).
                sum := sum + ((digitArray at: i) asInteger * factor).
                factor := factor - 1.
                i := i + 1
            ].

        mod := sum \\ 11.
        ( mod > 1 )
            ifTrue: [
                dvs at: 2 put: 11 - mod
            ].

        ^ dvs
    ]
]

cpf := CPF new.
cpf setNumero: '000.000.193'.
cpf setNumeroCompleto: '000.000.193-721'.

numero := cpf getNumero ifNil: [ '' ].
( numero isEmpty )
    ifTrue: [
        Transcript show: 'Número s/ dígitos verificadores ', 
            'não foi informado.'; nl
    ]
    ifFalse: [
        Transcript show: 'Número s/ dígitos verificadores: '; nl. 
        Transcript show: ' - ', cpf getNumero; nl
    ].

numeroCompleto := cpf getNumeroCompleto ifNil: [ '' ].
( numeroCompleto isEmpty )
    ifTrue: [
        Transcript show: 'Número c/ dígitos verificadores ', 
            'não foi informado.'; nl
    ]
    ifFalse: [
        Transcript show: 'Número c/ dígitos verificadores (um número a mais '.
        Transcript show: 'foi inserido, propositalmente): '; nl.
        Transcript show: ' - ', cpf getNumeroCompleto; nl
    ].

Transcript show: 'Número c/ dígitos verificadores ', 
    '(só num., preench. à esq. e com limite tamanho): '; nl.
Transcript show: ' - ', (cpf reterNumeros: numeroCompleto quantia: 11); nl.

dvs := cpf calcularDigitos.
Transcript show: 'Dígitos Verificadores a partir do número ',
    cpf getNumero, ':'; nl.
Transcript show: ' - ( ', (dvs at: 1) printString, ', ',
    (dvs at: 2) printString, ' )'; nl.

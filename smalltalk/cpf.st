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
                paddedNumbers := paddedNumbers copyFrom: 1 to: n.
            ].

        ^ paddedNumbers
    ]
]

cpf := CPF new.
cpf setNumero: '123'.
cpf setNumeroCompleto: '000.000.123-601'.

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
        Transcript show: 'Número c/ dígitos verificadores (um número a mais'.
        Transcript show: ' foi inserido, propositalmente): '; nl. 
        Transcript show: ' - ', cpf getNumeroCompleto; nl
    ].

Transcript show: 'Número c/ dígitos verificadores ', 
    '(só num., preench. à esq. e com limite tamanho): '; nl.
Transcript show: ' - ', (cpf reterNumeros: numeroCompleto quantia: 11); nl.

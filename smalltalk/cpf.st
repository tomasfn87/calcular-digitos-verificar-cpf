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

        ( onlyNumbers size = 0 )
            ifTrue: [
                ^ onlyNumbers
            ]. 

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
        | digits dvs factor i digitArray sum mod |

        digits := self reterNumeros: numero quantia: 9.
        ( digits size = 0 )
            ifTrue: [
                Transcript show: ' - ERRO: o CPF informado não possui números.'; nl.
                ^ digits
            ].

        dvs := #(0 0).

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

    CPF >> verificar [
        | cDigits temp dvsCalculados dvsRecebidos rDigits rDigitArray i |

        cDigits := (self reterNumeros: numeroCompleto quantia: 11) copyFrom: 1 to: 9.
        ( cDigits size = 0 )
            ifTrue: [
                Transcript show: ' - ERRO: o CPF informado não possui números.'; nl.
                ^ cDigits
            ]. 

        temp := self getNumero.
        self setNumero: cDigits.
        dvsCalculados := self calcularDigitos.
        self setNumero: temp. 

        ( dvsCalculados size = 2 )
            ifTrue: [
                Transcript show: 'Dígitos verificadores calculados: '; nl.
                Transcript show: ' - ( ',
                    (dvsCalculados at: 1) printString, ', ',
                    (dvsCalculados at: 2) printString, ' )'; nl
            ].

        dvsRecebidos := #(0 0).
        rDigits := self reterNumeros: numeroCompleto quantia: 11.
        rDigitArray := Array new: (rDigits size).

        i := 1.
        [ i <= rDigits size ]
            whileTrue: [
                rDigitArray at: i put: (rDigits copyFrom: i to: i).
                i := i + 1
            ].
        dvsRecebidos at: 1 put: (rDigitArray at: 10) asInteger.
        dvsRecebidos at: 2 put: (rDigitArray at: 11) asInteger.

        ( dvsRecebidos size = 2 )
            ifTrue: [
                Transcript show: 'Dígitos verificadores recebidos: '; nl.
                Transcript show: ' - ( ',
                    (dvsRecebidos at: 1) printString, ', ',
                    (dvsRecebidos at: 2) printString, ' )'; nl
            ].

        ( (dvsRecebidos at: 1) = (dvsCalculados at: 1)
            & (dvsRecebidos at: 2) = (dvsCalculados at: 2) )
            ifTrue: [
                ^ true
            ].
        ^ false
    ]
]

cpf := CPF new.
cpf setNumero: 'test'.
cpf setNumeroCompleto: '111.444.777-341'.

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
Transcript show: ''; nl.

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
Transcript show: ''; nl.

Transcript show: 'Número c/ dígitos verificadores ', 
    '(só num., preench. à esq. e com limite tamanho): '; nl.
Transcript show: ' - ', (cpf reterNumeros: numeroCompleto quantia: 11); nl.
Transcript show: ''; nl.

Transcript show: 'Dígitos Verificadores a partir do número "',
    cpf getNumero, '" :'; nl.
dvs := cpf calcularDigitos.
( dvs size = 2 )
    ifTrue: [
        Transcript show: ' - ( ',
            (dvs at: 1) printString, ', ', (dvs at: 2) printString, ' )'; nl
    ].
Transcript show: ''; nl.

Transcript show: 'CPF: ', ((cpf getNumeroCompleto) copyFrom: 1 to: 14); nl.
( cpf verificar )
    ifTrue: [
        Transcript show: ' - O CPF é válido.'; nl.
    ]
    ifFalse: [
        Transcript show: ' - O CPF não é válido.'; nl.
    ].
Transcript show: ''; nl.

cpf1 := CPF new.
cpf1 setNumeroCompleto: '111.444.777-35'.

Transcript show: 'CPF: ', cpf1 getNumeroCompleto; nl.
( cpf1 verificar )
    ifTrue: [
        Transcript show: ' - O CPF é válido.'; nl.
    ]
    ifFalse: [
        Transcript show: ' - O CPF não é válido.'; nl.
    ].

       IDENTIFICATION DIVISION.
       PROGRAM-ID. VerificarCPF.
      *
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
      *      Variável que armazena o primeiro argumento recebido por
      *    linha de comando: um número de CPF.
      *      O número de CPF pode conter de 1 a 14 caracteres numéricos,
      *    porém somente os 11 primeiros números serão utilizados no
      *    processo de verificação.
           01 CPF            PIC X(14).
      *
      *      Variável manipulada para iterar sobre o número de CPF.
           01 I              PIC 9(2).
      *
      *      Variável usada para registrar a quantia de caracteres
      *    numéricos presentes na variável CPF.
           01 NUM-COUNT      PIC 9(2) VALUE ZERO.
      *
      *      Variável usada para acompanhar o progresso do cálculo dos
      *    dígitos verificadores a partir do primeiros números do CPF
      *    (excluindo os dois últimos), para que sejam comparados com
      *    os dígitos verificadores recebidos na varíavel CPF.
      *      Obs.: mesmo números de CPF com apenas 1 dígito podem ser
      *    validados, pois, por exemplo, qualquer CPF equivalente a
      *    000.000.000-00 (i.e. apenas 0) é válido de acordo com o 
      *    algoritmo.
           01 COUNTER        PIC 9(2) VALUE ZERO.
      *
      *      Variável usada para receber cada número do CPF multiplicado
      *    por um fator descrescente, usada posteriormente para gerar o 
      *    resto de uma divisão por 11, que é então usada para definir 
      *    se o dígito verificador será diferente de zero.
           01 TEMP           PIC 9(3) VALUE ZERO.
      *
      *      Variável que corresponde à quantia de números mais um,
      *    excluindo os dois últimos números, que são os dígitos
      *    verificadores.
           01 FACTOR         PIC 9(2) VALUE 10.
      *
      *      Variável que armazena o resultado de divisão por 11 do
      *    valor acumulado das multiplicações por um fator decrescente
      *    na variável TEMP - esse valor não é usado, mas é necessário
      *    apontar uma variável para obter o resto.
           01 DIV-RESULT     PIC 9.
      *
      *      Variável que recebe o resto da divisão, e que é de fato
      *    usado para o cálculo de dígito verificador: caso seja maior 
      *    que 1, o digito verificador será diferente de zero.
           01 REMAIN         PIC 9(2).
      *
      *      Variável que armazena a posição do primeiro dígito
      *    verificador recebido - quando apenas um número for recebido,
      *    esse valor será zero.
           01 DV-REC-1-POS   PIC 9(2) VALUE 10.
      *
      *      Variável que armazena a posição do segundo dígito
      *    verificador recebido.
           01 DV-REC-2-POS   PIC 9(2) VALUE 11.
      *
      *      Variável que armazena o valor do primeiro dígito
      *    verificador recebido.
           01 DV-RECEBIDO-1  PIC 9    VALUE ZERO.
      *
      *      Variável que armazena o valor do segundo dígito
      *    verificador recebido - quando apenas um número for recebido,
      *    esse valor será zero.
           01 DV-RECEBIDO-2  PIC 9    VALUE ZERO.
      *
      *      Variável que armazena o valor do primeiro dígito
      *    verificador calculado.
           01 DV-CALCULADO-1 PIC 9    VALUE ZERO.
      *
      *      Variável que armazena o valor do segundo dígito
      *    verificador calculado.
           01 DV-CALCULADO-2 PIC 9    VALUE ZERO.
      *
       PROCEDURE DIVISION CHAINING CPF.
      *      Soma para verificação do número de caracteres numéricos
      *    presentes no CPF recebido:
           PERFORM VARYING I FROM 1 BY 1 UNTIL I GREATER THAN 14
             IF CPF(I:1) IS NUMERIC
               ADD 1 TO NUM-COUNT
             END-IF
           END-PERFORM.
      *      Caso o CPF recebido não possua nenhum número, o programa
      *    será encerrado:
           IF NUM-COUNT LESS THAN 1
             DISPLAY "ERRO: o CPF informado não contém números."
             STOP RUN
           END-IF.
      *      Determinar a posição dos dígitos verificadores recebidos:
           IF NUM-COUNT LESS THAN 11
             COMPUTE DV-REC-1-POS = NUM-COUNT - 1
             COMPUTE DV-REC-2-POS = NUM-COUNT
           END-IF.
      *      Determinar o valor do primeiro dígito verificador recebido:
           IF DV-REC-1-POS GREATER THAN ZERO
             PERFORM VARYING I FROM 1 BY 1 UNTIL I GREATER THAN 14
               IF CPF(I:1) IS NUMERIC
                 ADD 1 TO TEMP
                 IF TEMP EQUALS DV-REC-1-POS
                   COMPUTE DV-RECEBIDO-1 =
                     FUNCTION NUMVAL(CPF(I:1))
                 END-IF
               END-IF
             END-PERFORM
           END-IF.
      *      Zerar a variável temporária:
           COMPUTE TEMP = ZERO.
      *      Determinar o valor do segundo dígito verificador recebido:
           PERFORM VARYING I FROM 1 BY 1 UNTIL I GREATER THAN 14
             IF CPF(I:1) IS NUMERIC
               ADD 1 TO TEMP
               IF TEMP EQUALS DV-REC-2-POS
                 COMPUTE DV-RECEBIDO-2 =
                   FUNCTION NUMVAL(CPF(I:1))
               END-IF
             END-IF
           END-PERFORM.
      *      Zerar a variável temporária (1):
           COMPUTE TEMP = ZERO.
      *      Verificar se é necessário ajuste do fator de multiplicação:
           IF NUM-COUNT LESS THAN 11
             COMPUTE FACTOR = FACTOR - (11 - NUM-COUNT)
           END-IF.
      *      Multiplicar os números do CPF a partir do valor inicial do
      *    fator, decrescendo 1 do fator a cada iteração:
           PERFORM VARYING I FROM 1 BY 1 UNTIL I GREATER THAN 14
             IF CPF(I:1) IS NUMERIC
               COMPUTE TEMP =
                 TEMP + (FUNCTION NUMVAL(CPF(I:1)) * FACTOR)
               ADD -1 TO FACTOR
               ADD 1 TO COUNTER
               IF COUNTER EQUALS DV-REC-1-POS - 1
                 EXIT PERFORM
               END-IF
             END-IF
           END-PERFORM.
      *      Zerar o contador:
           COMPUTE COUNTER = ZERO.
      *      Obter o resto da soma das multiplicações dividida por 11:
           DIVIDE TEMP BY 11 GIVING DIV-RESULT REMAINDER REMAIN.
      *      Zerar a variável temporária (2):
           COMPUTE TEMP = ZERO.
      *      Caso o resto da divisão seja maior que 1, o valor do
      *    primeiro dígito verificador será alterado, permanecendo zero
      *    caso contrário:
           IF REMAIN GREATER THAN 1
             COMPUTE DV-CALCULADO-1 = 11 - REMAIN
           END-IF.
      *      Redefinir o valor base do fator para 11, pois agora já
      *    estamos em posse do primeiro dígitos verificador:
           COMPUTE FACTOR = 11.
      *      Caso o CPF informado tenha menos de 11 números, será feito
      *    um reajuste do fator para que se adeque à situação, pois os
      *    números de CPF podem ser iniciados por zeros, o que também
      *    significa que os zeros podem ser omitidos (tanto do ponto de
      *    vista computacional quanto semântico):
           IF NUM-COUNT LESS THAN 11
             COMPUTE FACTOR = FACTOR - (11 - NUM-COUNT)
           END-IF.
      *      Multiplicar os números do CPF a partir do novo valor do
      *    fator, descrescendo 1 do fator a cada iteração:
           PERFORM VARYING I FROM 1 BY 1 UNTIL I GREATER THAN 14
             IF CPF(I:1) IS NUMERIC
               COMPUTE TEMP =
                 TEMP + (FUNCTION NUMVAL(CPF(I:1)) * FACTOR)
               ADD -1 TO FACTOR
               ADD 1 TO COUNTER
               IF COUNTER EQUALS DV-REC-1-POS - 1
                 EXIT PERFORM
               END-IF
             END-IF
           END-PERFORM.
      *      Acrescentar o valor do primeiro dígito verificador (essa é
      *    a explicação para a existência de dois dígitos verificadores:
      *    o prímeiro dígito calculado entra no cálculo do segundo, o
      *    que torna o algoritmo mais confiável):
           COMPUTE TEMP = TEMP + DV-CALCULADO-1 * FACTOR.
      *      Obter o resto da soma das multiplicações dividida por 11:
           DIVIDE TEMP BY 11 GIVING DIV-RESULT REMAINDER REMAIN.
      *      Caso o resto da divisão seja maior que 1, o valor do
      *    segundo dígito verificador será alterado, permanecendo zero
      *    caso contrário:
           IF REMAIN GREATER THAN 1
             COMPUTE DV-CALCULADO-2 = 11 - REMAIN
           END-IF.
      *      A verificação do CPF é a comparação dos dígitos
      *    verificadores recebidos com os dígitos verificadores
      *    calculados:
           IF DV-RECEBIDO-1 EQUALS DV-CALCULADO-1
             AND DV-RECEBIDO-2 EQUALS DV-CALCULADO-2
             DISPLAY "O CPF é válido."
           ELSE
             DISPLAY "O CPF é inválido."
           END-IF.
      *
       STOP RUN.

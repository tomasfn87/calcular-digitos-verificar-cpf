       IDENTIFICATION DIVISION.
       PROGRAM-ID. VerificarCPF.
      *
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 CPF            PIC 9(14).
           01 I              PIC 9(2).
           01 NUM-COUNT      PIC 9(2) VALUE ZERO.
           01 COUNTER        PIC 9(2) VALUE ZERO.
           01 TEMP           PIC 9(3) VALUE ZERO.
           01 FACTOR         PIC 9(2) VALUE 10.
           01 REMAIN         PIC 9(2).
           01 DIV-RESULT     PIC 9.
           01 DV-REC-1-POS   PIC 9(2) VALUE 10.
           01 DV-REC-2-POS   PIC 9(2) VALUE 11.
           01 DV-RECEBIDO-1  PIC 9    VALUE ZERO.
           01 DV-RECEBIDO-2  PIC 9    VALUE ZERO.
           01 DV-CALCULADO-1 PIC 9    VALUE ZERO.
           01 DV-CALCULADO-2 PIC 9    VALUE ZERO.
      *
       PROCEDURE DIVISION CHAINING CPF.
      *      Soma para verificação do número de caracteres numéricos
      *    presentes no CPF recebido:
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 14
             IF CPF(I:1) IS NUMERIC
               ADD 1 TO NUM-COUNT
             END-IF
           END-PERFORM.
      *      Caso o CPF recebido não possua nenhum número, o programa 
      *    será encerrado:
           IF NUM-COUNT LESS THAN 1
             DISPLAY "ERRO: CPF informado não contém números."
             STOP RUN
           END-IF.
      *      Determinar a posição dos dígitos verificadores recebidos:
           IF NUM-COUNT LESS THAN 11
             COMPUTE DV-REC-1-POS = NUM-COUNT - 1
             COMPUTE DV-REC-2-POS = NUM-COUNT
           END-IF.
      *      Determinar o valor do primeiro dígito verificador recebido:
           IF DV-REC-1-POS GREATER THAN ZERO
             PERFORM VARYING I FROM 1 BY 1 UNTIL I > 14
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
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 14
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
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 14
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
           IF REMAIN > 1
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
             COMPUTE FACTOR = 11 - (11 - NUM-COUNT)
           END-IF.
      *      Multiplicar os números do CPF a partir do novo valor do 
      *    fator, descrescendo 1 do fator a cada iteração:
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 14
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
      *    o prímeiro dígito calculado entra na segunda iteração):
           COMPUTE TEMP = TEMP + DV-CALCULADO-1 * FACTOR.
      *      Obter o resto da soma das multiplicações dividida por 11:
           DIVIDE TEMP BY 11 GIVING DIV-RESULT REMAINDER REMAIN.
      *      Caso o resto da divisão seja maior que 1, o valor do
      *    segundo dígito verificador será alterado, permanecendo zero
      *    caso contrário:
           IF REMAIN > 1 
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

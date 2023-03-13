#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

const char* reterNumeros(
    char cpf[],
    int n,
    bool loud);

int main(int argc, char* argv[]) {
    if (argc > 1)
       reterNumeros(argv[1], 11, true);
    return 0;}

const char* reterNumeros(char cpf[], int n, bool loud) {
    if (n == 0)
        return "";
    char digitos[n+1];
    digitos[n] = 0;
    int contadorDigitos = 0;
    for (int i = strlen(cpf) - 1; i >= 0; i--) {
        char ASCIIDigito[3];
        sprintf(ASCIIDigito, "%d", cpf[i]);
        if (strcmp(ASCIIDigito, "47") > 0
            && strcmp(ASCIIDigito, "58") < 0) {
            contadorDigitos++;}}
    if (contadorDigitos == 0) {
        if (loud)
            printf("- nenhum dígito recebido.\n");
        return "";}
    int limit;
    if (contadorDigitos > n) {
        limit = n - 1;
        if (loud)
            printf("- dígitos = %d (%d a mais).\n", contadorDigitos, (contadorDigitos-n));
    } else
        limit = strlen(cpf);
    int posDigito = n - 1;
    for (int i = limit; i >= 0; i--) {
        char ASCIIDigito[3];
        sprintf(ASCIIDigito, "%d", cpf[i]);
        if (strcmp(ASCIIDigito, "47") > 0
            && strcmp(ASCIIDigito, "58") < 0) {
            digitos[posDigito] = cpf[i];
            posDigito--;}}
    if (contadorDigitos < n) {
        if (loud)
            printf("- dígitos = %d de %d.\n", contadorDigitos, n);
        int missingNums = n - contadorDigitos;
        for (int i = 0; i < missingNums; i++)
            digitos[i] = "0"[0];}
    if (loud)
        for (int i = 0; i < n; i++)
            printf("- digitos[%d] = %c\n", i, digitos[i]);
    if (loud && n == 11)
        printf("- CPF = %c%c%c.%c%c%c.%c%c%c-%c%c\n", digitos[0],
        digitos[1], digitos[2], digitos[3], digitos[4], digitos[5],
        digitos[6], digitos[7], digitos[8], digitos[9], digitos[10]);
    if (loud)
        printf("- digitos = %s\n", digitos);
    char* d;
    d = (char *) malloc((n+1) * sizeof (char));
    strcpy(d, digitos);
    return d;}

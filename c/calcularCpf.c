#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct Digitos{
    int values[11];
};

struct DigitosVerificadoresCPF{
    int values[2];
};

struct DigitosVerificadoresCPF calcularDigitos(
    char cpf[],
    bool loud);

struct Digitos obterDigitos(
    char cpf[],
    int n,
    bool loud);

const char* reterNumeros(
    char cpf[],
    int n,
    bool loud);

int main(int argc, char* argv[]) {
    if (argc > 1) {
       reterNumeros(argv[1], 11, true);
       printf("\n");
       obterDigitos(argv[1], 11, true);
       printf("\n");
       calcularDigitos(argv[1], true);}
    return 0;}

struct DigitosVerificadoresCPF calcularDigitos(char cpf[], bool loud) {
    struct Digitos digitosCpf = obterDigitos(cpf, 9, false);
    int multiplicador = 10;
    int soma = 0;
    for (int i = 0; i < 9; i++) {
        soma = soma + (digitosCpf.values[i] * multiplicador);
        multiplicador--;}
    int resto = soma % 11;
    struct DigitosVerificadoresCPF dvs;
    if (resto < 2)
       dvs.values[0] = 0;
    else
       dvs.values[0] = 11 - resto;
    if (loud)
        printf("- primeiro dígito = %d\n", dvs.values[0]);
    multiplicador = 11;
    soma = 0;
    for (int i = 0; i < 9; i++) {
        soma = soma + (digitosCpf.values[i] * multiplicador);
        multiplicador--;}
    soma = soma + (dvs.values[0] * multiplicador);
    resto = soma % 11;
    if (resto < 2)
       dvs.values[1] = 0;
    else
       dvs.values[1] = 11 - resto;
    if (loud)
        printf("- segundo dígito = %d\n", dvs.values[1]);
    return dvs;}

struct Digitos obterDigitos(char cpf[], int n, bool loud) {
    struct Digitos digitosCpf;
    const char* Cpf = reterNumeros(cpf, n, false);
    for (int i = 0; i < strlen(Cpf); i++) {
        int d = 0;
        d = d * 10 + (Cpf[i] - 48);
        digitosCpf.values[i] = d;
        if (loud)
            printf("- digitos[%d] = %d (int)\n", i, d);}
    return digitosCpf;}

const char* reterNumeros(char cpf[], int n, bool loud) {
    if (n == 0)
        return "";
    char digitos[n+1];
    digitos[n] = 0;
    int contadorDigitos = 0;
    int posicaoUltimoNumero = -1;
    for (int i = 0 ; i < strlen(cpf); i++) {
        char ASCIIDigito[3];
        sprintf(ASCIIDigito, "%d", cpf[i]);
        if (strcmp(ASCIIDigito, "47") > 0
            && strcmp(ASCIIDigito, "58") < 0) {
            contadorDigitos++;
            if (contadorDigitos == n)
                posicaoUltimoNumero = i;}};
    if (loud && posicaoUltimoNumero >= 0)
        printf("- posicao ultimo numero = %d\n", posicaoUltimoNumero + 1);
    if (contadorDigitos == 0) {
        if (loud)
            printf("- nenhum dígito recebido.\n");
        return "";}
    int limit;
    if (contadorDigitos > n) {
        limit = posicaoUltimoNumero;
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
            printf("- digitos[%d] = %c (char)\n", i, digitos[i]);
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

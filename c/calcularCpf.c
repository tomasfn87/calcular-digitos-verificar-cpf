#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct Digitos{
    int valores[11];};

struct DigitosVerificadoresCPF{
    int valores[2];};

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
        printf("reterNumeros(cpf = \"%s\", n = 11, loud = true):\n", argv[1]);
        reterNumeros(argv[1], 11, true);
        printf("\n");
        printf("reterNumeros(cpf = \"%s\", n = 9, loud = true):\n", argv[1]);
        reterNumeros(argv[1], 9, true);
        printf("\n");
        printf("obterDigitos(cpf = \"%s\", n = 11, loud = true):\n", argv[1]);
        obterDigitos(argv[1], 11, true);
        printf("\n");
        printf("obterDigitos(cpf = \"%s\", n = 9, loud = true):\n", argv[1]);
        obterDigitos(argv[1], 9, true);
        printf("\n");
        printf("calcularDigitos(cpf = \"%s\", loud = true):\n", argv[1]);
        calcularDigitos(argv[1], true);}
    return 0;}

struct DigitosVerificadoresCPF calcularDigitos(char cpf[], bool loud) {
    struct Digitos digitosCpf = obterDigitos(cpf, 9, false);
    struct DigitosVerificadoresCPF dvs;
    dvs.valores[0] = 0;
    dvs.valores[1] = 0;
    int multiplicador = 10;
    int resto, soma = 0;
    for (int i = 0; i < 9; i++) {
        soma = soma + (digitosCpf.valores[i] * multiplicador);
        multiplicador--;}
    resto = soma % 11;
    if (resto > 1)
       dvs.valores[0] = 11 - resto;
    if (loud)
        printf("- primeiro dígito = %d\n", dvs.valores[0]);
    multiplicador = 11;
    soma = 0;
    for (int i = 0; i < 9; i++) {
        soma = soma + (digitosCpf.valores[i] * multiplicador);
        multiplicador--;}
    soma = soma + (dvs.valores[0] * multiplicador);
    resto = soma % 11;
    if (resto < 2)
       dvs.valores[1] = 0;
    else
       dvs.valores[1] = 11 - resto;
    if (loud)
        printf("- segundo dígito = %d\n", dvs.valores[1]);
    return dvs;}

struct Digitos obterDigitos(char cpf[], int n, bool loud) {
    struct Digitos digitosCpf;
    const char* Cpf = reterNumeros(cpf, n, false);
    for (int i = 0; i < strlen(Cpf); i++) {
        int d = Cpf[i] - 48;
        digitosCpf.valores[i] = d;
        if (loud)
            printf("- digitos[%d] = %d (int)\n", i, d);}
    return digitosCpf;}

const char* reterNumeros(char cpf[], int n, bool loud) {
    if (n < 1)
        return "";
    int posicaoUltimoNumero = -1;
    int contadorDigitos = 0;
    int numsFaltantes, limite, posDigito;
    char digitos[n+1];
    char* d;
    digitos[n] = 0;
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
    if (contadorDigitos > n) {
        limite = posicaoUltimoNumero;
        if (loud)
            printf("- dígitos = %d (%d a mais).\n", contadorDigitos, (contadorDigitos-n));
    } else
        limite = strlen(cpf);
    posDigito = n - 1;
    for (int i = limite; i >= 0; i--) {
        char ASCIIDigito[3];
        sprintf(ASCIIDigito, "%d", cpf[i]);
        if (strcmp(ASCIIDigito, "47") > 0
            && strcmp(ASCIIDigito, "58") < 0) {
            digitos[posDigito] = cpf[i];
            posDigito--;}}
    if (contadorDigitos < n) {
        if (loud)
            printf("- dígitos = %d de %d.\n", contadorDigitos, n);
        numsFaltantes = n - contadorDigitos;
        for (int i = 0; i < numsFaltantes; i++)
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
    d = (char *) malloc((n+1) * sizeof (char));
    strcpy(d, digitos);
    return d;}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct DigitosVerificadoresCPF{int valores[2];};

struct Digitos{int valores[11];};

bool verificar(char cpf[], bool loud);

struct DigitosVerificadoresCPF calcularDigitos(const char cpf[], bool loud);

struct Digitos obterDigitos(const char cpf[], int n, bool loud);

const char* reterNumeros(const char cpf[], int n, bool loud);

int main(int argc, char* argv[]) {
    if (argc > 2) {
        if (strcmp(argv[1], "-c") == 0 || strcmp(argv[1], "--calcular") == 0)
            calcularDigitos(argv[2], true);
        else if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--verificar") == 0)
            verificar(argv[2], true);}
    else {
        printf(" * Digite '-c' ou '--calcular' e um número de CPF para calcular os dígitos verificadores do CPF.\n");
        printf(" * Digite '-v' ou '--verificar' e um número de CPF para verificar o CPF.\n");}
    return 0;}

bool verificar(char cpf[], bool loud) {
    struct Digitos digitosCpf = obterDigitos(cpf, 11, false);
    struct DigitosVerificadoresCPF dvsRecebidos = { 0 };
    dvsRecebidos.valores[0] = digitosCpf.valores[9];
    dvsRecebidos.valores[1] = digitosCpf.valores[10];
    const char* cpfCompleto = reterNumeros(cpf, 11, false);
    char cpfCalculo[10];
    strncpy(cpfCalculo, cpfCompleto, 9);
    cpfCalculo[9] = '\0';
    struct DigitosVerificadoresCPF dvsCalculados = calcularDigitos(cpfCalculo, false);
    if (loud) {
        printf("O CPF ");
        for (int i = 0; i < 9; i++) {
            if (i == 3 || i == 6)
                printf(".");
            printf("%d", digitosCpf.valores[i]);}
        printf("-%d%d ", dvsRecebidos.valores[0], dvsRecebidos.valores[1]);
        printf("é ");}
    if (dvsRecebidos.valores[0] == dvsCalculados.valores[0] &&
        dvsRecebidos.valores[1] == dvsCalculados.valores[1]) {
        if (loud)
            printf("válido.\n");
        return true;}
    if (loud)
        printf("inválido.\n");
    return false;}

struct DigitosVerificadoresCPF calcularDigitos(const char cpf[], bool loud) {
    struct Digitos digitosCpf = obterDigitos(cpf, 9, false);
    struct DigitosVerificadoresCPF dvs = { 0 };
    int multiplicador = 10;
    int resto, soma = 0;
    for (int i = 0; i < 9; i++) {
        soma += digitosCpf.valores[i] * multiplicador;
        multiplicador--;}
    resto = soma % 11;
    if (resto > 1)
        dvs.valores[0] = 11 - resto;
    multiplicador = 11;
    soma = 0;
    for (int i = 0; i < 9; i++) {
        soma += digitosCpf.valores[i] * multiplicador;
        multiplicador--;}
    soma += dvs.valores[0] * multiplicador;
    resto = soma % 11;
    if (resto > 1)
        dvs.valores[1] = 11 - resto;
    if (loud) {
        for (int i = 0; i < 9; i++) {
            if (i == 3 || i == 6)
                printf(".");
            printf("%d", digitosCpf.valores[i]);}
        printf("-%d%d\n", dvs.valores[0], dvs.valores[1]);
        for (int i = 0; i < 9; i++) {
            printf("%d", digitosCpf.valores[i]);}
        printf("%d%d\n", dvs.valores[0], dvs.valores[1]);
        printf("[ %d, %d ]\n", dvs.valores[0], dvs.valores[1]);}
    return dvs;}

struct Digitos obterDigitos(const char cpf[], int n, bool loud) {
    struct Digitos digitosCpf;
    const char* Cpf = reterNumeros(cpf, n, false);
    for (int i = 0; i < strlen(Cpf); i++) {
        int d = Cpf[i] - '0';
        digitosCpf.valores[i] = d;
        if (loud)
            printf("- digitos[%d] = %d (int)\n", i, d);}
    return digitosCpf;}

const char* reterNumeros(const char cpf[], int n, bool loud) {
    if (n < 1)
        return "";
    int posicaoUltimoNumero = -1;
    int contadorDigitos = 0;
    int numsFaltantes, limite, posDigito;
    char digitos[n+1];
    char* d;
    digitos[n] = 0;
    for (int i = 0 ; i < strlen(cpf); i++) {
        if (cpf[i] > 47 && cpf[i] < 58) {
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
            printf("- dígitos = %d (%d a mais).\n", contadorDigitos, (contadorDigitos-n));}
    else
        limite = strlen(cpf);
    posDigito = n - 1;
    for (int i = limite; i >= 0; i--) {
        if (cpf[i] > 47 && cpf[i] < 58) {
            digitos[posDigito] = cpf[i];
            posDigito--;}}
    if (contadorDigitos < n) {
        if (loud)
            printf("- dígitos = %d de %d.\n", contadorDigitos, n);
        numsFaltantes = n - contadorDigitos;
        for (int i = 0; i < numsFaltantes; i++)
            digitos[i] = '0';}
    if (loud)
        for (int i = 0; i < n; i++)
            printf("- digitos[%d] = %c (char)\n", i, digitos[i]);
    if (loud && n == 11) {
        printf("- CPF = ");
        for (int i = 0; i < 11; i++) {
            if (i == 3 || i == 6)
                printf(".");
            else if (i == 9)
                printf("-");
            printf("%c", digitos[i]);}
        printf("\n");}
    if (loud)
        printf("- digitos = %s\n", digitos);
    d = (char *) malloc((n+1) * sizeof (char));
    strcpy(d, digitos);
    return d;}

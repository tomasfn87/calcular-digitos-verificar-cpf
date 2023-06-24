public class Cpf {
    public static void main(String[] args) {
        if (args.length > 1) {
            if (args[0].equals("-c") || args[0].equals("--calcular")) {
                if (isNumeric(args[1])) {
                    int[] dvs = calcularDigitos(args[1], true);
                    System.out.printf("{ %d, %d }%n", dvs[0], dvs[1]);}
                else {
                    System.out.println(
                        "ERRO: o segundo argumento deve possuir ao menos um número para que seja realizado o cálculo dos dígitos verificadores do CPF.");}}
            else if (args[0].equals("-v") || args[0].equals("--verificar")) {
                if (isNumeric(args[1])) {
                    boolean valid = verificar(args[1]);
                    if (!valid) {
                        System.out.printf("O CPF %s é inválido%n", marcar(args[1], ' ', ' '));}
                    else {
                        System.out.printf("O CPF %s é válido%n", marcar(args[1], ' ', ' '));}}
                else {
                    System.out.println(
                        "ERRO: o segundo argumento deve possuir ao menos um número para que seja realizada a verificação do CPF.");}}}
        else {
            System.out.println(
                "   - digite '-c' ou '--calcular' e um número de CPF para calcular os dígitos verificadores do CPF");
            System.out.println(
                "   - digite '-v' ou '--verificar' e um número de CPF para verificar o CPF");}}

    public static boolean isNumeric(String str) {
        if (str.length() < 1) {
            return false;}
        str = str.replaceAll("\\D", "");
        if (str.length() > 0) {
            return true;}
        return false;}

    public static int[] calcularDigitos(String cpf, boolean loud) {
        String cpfRecebido = padLeftAndLimit(cpf.replaceAll("\\D", ""), 9, "0");
        int soma = 0;
        int resto = 0;
        int multiplicador = 10;
        int[] dvs = { 0, 0 };
        for (int i = 0; i < 9; i++) {
            soma += Integer.parseInt(cpfRecebido.substring(i, i+1)) * multiplicador;
            multiplicador--;}
        resto = soma % 11;
        if (resto > 1)
            dvs[0] = 11 - resto;
        soma = 0;
        multiplicador = 11;
        for (int i = 0; i < 9; i++) {
            soma += Integer.parseInt(cpfRecebido.substring(i, i+1)) * multiplicador;
            multiplicador--;}
        soma += dvs[0] * multiplicador;
        resto = soma % 11;
        if (resto > 1)
            dvs[1] = 11 - resto;
        if (loud) {
            System.out.printf("%s%n", String.format("%s.%s.%s-%d%d",
                cpfRecebido.substring(0, 3), cpfRecebido.substring(3, 6),
                cpfRecebido.substring(6, 9), dvs[0], dvs[1]));
            System.out.printf("%s%n", String.format("%s%d%d",
                cpfRecebido.substring(0, 9), dvs[0], dvs[1]));}
        return dvs;}

    public static boolean verificar(String cpf) {
        String cpfRecebido = padLeftAndLimit(cpf.replaceAll("\\D", ""), 11, "0");
        int[] dvsRecebidos = {
            Integer.parseInt(cpfRecebido.substring(9, 10)),
            Integer.parseInt(cpfRecebido.substring(10, 11))};
        int[] dvsCalculados = calcularDigitos(cpfRecebido, false);
        if (dvsRecebidos[0] == dvsCalculados[0]
            && dvsRecebidos[1] == dvsCalculados[1])
            return true;
        return false;}

    public static String marcar(String cpf, char marcador1, char marcador2) {
        cpf = cpf.replaceAll("\\D", "");
        cpf = padLeftAndLimit(cpf, 11, "0");
        if (marcador1 == ' ')
            marcador1 = '.';
        if (marcador2 == ' ')
            marcador2 = '-';
        return String.format("%s%c%s%c%s%c%s",
            cpf.substring(0, 3), marcador1,
            cpf.substring(3, 6), marcador1,
            cpf.substring(6, 9), marcador2,
            cpf.substring(9, 11));}

    private static String padLeftAndLimit(String str, int n, String chr) {
        if (str == "" || n <= str.length())
            return str;
        if (chr.length() > 1)
            chr = chr.substring(0, 1);
        if (str.length() >= n)
            return str.substring(0, n);
        String pad = chr.repeat(n - str.length());
        return String.format("%s%s", pad, str);}}

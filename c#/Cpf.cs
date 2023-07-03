using System;

namespace cpf {
    class MainClass {
        public static void Main(string[] args) {
            if (args.Length > 1) {
                if (args[0] == "-c" || args[0] == "--calcular") {
                    if (ReterNumeros(args[1], 1).Length > 0) {
                        string cpf = ReterNumeros(args[1], 9);
                        int[] d = CalcularDigitos(args[1]);
                        cpf += $"{d[0]}{d[1]}";
                        string cpfF = $"{cpf.Substring(0, 3)}";
                        cpfF += $".{cpf.Substring(3, 3)}";
                        cpfF += $".{cpf.Substring(6, 3)}";
                        cpfF += $"-{d[0]}{d[1]}";
                        Console.WriteLine(cpfF);
                        Console.WriteLine(cpf);
                        Console.WriteLine($"[ {d[0]}, {d[1]} ]");}
                    else {
                        Console.WriteLine("ERRO: o CPF deve conter pelo menos um número.");}}
                else if (args[0] == "-v" || args[0] == "--verificar") {
                    if (ReterNumeros(args[1], 1).Length > 0) {
                        bool valido = Verificar(args[1]);
                        string cpf = ReterNumeros(args[1], 11);
                        string cpfF = $"{cpf.Substring(0, 3)}";
                        cpfF += $".{cpf.Substring(3, 3)}";
                        cpfF += $".{cpf.Substring(6, 3)}";
                        cpfF += $"-{cpf.Substring(9, 2)}";
                        string v = "válido";
                        if (valido) {
                            Console.WriteLine($"O CPF {cpfF} é {v}.");}
                        else {
                            Console.WriteLine($"O CPF {cpfF} é in{v}.");}}
                    else {
                        Console.WriteLine("ERRO: o CPF deve conter pelo menos um número.");}}}
            else {
                Console.WriteLine(" * Digite '-c' ou '--calcular' e um número de CPF para efetuar o cálculo de dígitos de CPF");
                Console.WriteLine(" * Digite '-v' ou '--verificar' e um número de CPF para efetuar a verificação de CPF");}}

        private static bool Verificar(string cpf) {
            string cpfRecebido = ReterNumeros(cpf, 11);
            int[] digitosRecebidos = new int[2];
            digitosRecebidos[0] = cpfRecebido[9] - '0';
            digitosRecebidos[1] = cpfRecebido[10] - '0';
            int[] digitosCalculados = CalcularDigitos(cpfRecebido.Substring(0, 9));
            if (digitosCalculados[0] == digitosRecebidos[0]
                && digitosCalculados[1] == digitosRecebidos[1]) {
                return true;}
            return false;}

        private static int[] CalcularDigitos(string cpf) {
            int[] digitos = new int[2];
            string Cpf = ReterNumeros(cpf, 9);
            int multiplicador = 10;
            int soma = 0;
            int resto = 0;
            foreach (char c in Cpf) {
                soma += (c - '0') * multiplicador;
                multiplicador -= 1;}
            resto = soma % 11;
            if (resto > 1) {
                digitos[0] = 11 - resto;}
            multiplicador = 11;
            soma = 0;
            foreach (char c in Cpf) {
                soma += (c - '0') * multiplicador;
                multiplicador -= 1;}
            soma += digitos[0] * multiplicador;
            resto = soma % 11;
            if (resto > 1) {
                digitos[1] = 11 - resto;}
            return digitos;}

        private static string ReterNumeros(string cpf, int n) {
            string nums = "";
            int count = 0;
            foreach (char c in cpf) {
                if (char.IsDigit(c)) {
                    nums += c;
                    count++;}
                if (count == n) {
                    break;}}
            if (nums.Length < 1) {
                return "";}
            if (nums.Length < n) {
                return nums.PadLeft(n, '0');}
            return nums;}}}
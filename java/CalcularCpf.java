public class CalcularCpf {
    public static void main(String[] args) {
        if (args.length > 0 && args[0] != "") {
            Cpf cpf = new Cpf(args[0]);
            System.out.println("CPF recebido:");
            System.out.printf("- %s%n", cpf.toString(' ', ' '));
            System.out.printf("- %s%n", cpf.getCpf());
            System.out.println("\nCálculo dígitos verificadores do CPF recebido:");
            int[] dvs = cpf.calcularDigitos();
            System.out.printf("%d, %d%n", dvs[0], dvs[1]);
        }
    }
}
public class CalcularCpf {
    public static void main(String[] args) {
        if (args[0] != "") {
            Cpf cpf = new Cpf(args[0]);
            System.out.println(cpf.getCpf());
            System.out.println(cpf.toString(' ', ' '));
            int[] dvs = cpf.calcularDigitos(); 
        }
    }
}


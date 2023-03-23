public class CalcularCpf {
    public static void main(String[] args) {
        Cpf cpf = new Cpf("11144477711");
        System.out.println(cpf.getCpf());
        System.out.println(cpf.toString(".", "-"));
        int[] dvs = cpf.calcularDigitos(); // 3, 5
    }
}


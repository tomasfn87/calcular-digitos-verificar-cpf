import java.util.ArrayList;

public class Cpf {
    private String cpf;
    public void setCpf(String cpf) {
        this.cpf = cpf.replaceAll("\\D", "");
    }
    public String getCpf() {
        return this.cpf;
    }
    public Cpf(String cpf) {
        cpf = cpf.replaceAll("\\D", "");
        cpf = padLeft(cpf, 11, "0");
        if (cpf.length() > 0)
            this.cpf = cpf;
        else
            this.cpf = "";
    }
    public String toString(String marcador1, String marcador2) {
        marcador1 = marcador1.substring(0, 1);
        marcador2 = marcador2.substring(0, 1);
        return String.format("%s%s%s%s%s%s%s",
            this.cpf.substring(0, 3), marcador1,
            this.cpf.substring(3, 6), marcador1,
            this.cpf.substring(6, 9), marcador2,
            this.cpf.substring(9, 11)
        );
    }
    public int[] calcularDigitos() {
        int soma = 0;
        int resto = 0;
        int multiplicador = 10;
        int[] dvs = {0, 0};
        String cpf = this.cpf.substring(0, 9);
        ArrayList<Integer> digitos = getNumericStringAsIntegerArray(cpf);
        for (int i=0; i<9; i++) {
            soma = soma + (digitos.get(i) * multiplicador);
            multiplicador--;
        }
        resto = soma % 11;
        if (resto > 1)
            dvs[0] = 11 - resto;
        soma = 0;
        resto = 0;
        multiplicador = 11;
        digitos.add(dvs[0]);
        System.out.println();
        for (int i=0; i<10; i++) {
            soma += (digitos.get(i) * multiplicador);
            multiplicador -= 1;
        }
        resto = soma % 11;
        if (resto > 1)
            dvs[1] = 11 - resto;
        System.out.printf("dígitos verificadores: [%d, %d]%n", dvs[0], dvs[1]);
        System.out.printf("CPF completo: %s%n",
            String.format("%s.%s.%s-%d%d",
            this.cpf.substring(0, 3),
            this.cpf.substring(3, 6),
            this.cpf.substring(6, 9),
            dvs[0], dvs[1])
        );
        return dvs;
    }
    private String padLeft(String str, int n, String chr) {
        if (str == "" || chr.length() < 1 || n <= str.length())
            return str;
        if (chr.length() > 1)
            chr = chr.substring(0, 1);
        String pad = chr.repeat(n - str.length());
        return String.format("%s%s", pad, str);
    }
    private ArrayList<Integer> getNumericStringAsIntegerArray(String num) {
        ArrayList<Integer> nums = new ArrayList<Integer>();
        for (int i=0; i<num.length(); i++) {
            int n = Integer.parseInt(num.substring(i, i+1)); 
            nums.add(n);
        }
        return nums;
    }
}

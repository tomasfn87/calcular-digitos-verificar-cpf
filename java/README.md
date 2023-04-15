# Calcular Dígitos CPF

## Compilar


```shell
javac Cpf.java CalcularCpf.java
```

## Executar

```shell
java CalcularCpf 98765432111
```

<br>

## Como usar

- Passar um número para cálculo dos dígitos verificadores;
- Caso menos de 11 números forem recebidos, o número será preenchido com zeros à esquerda;

### _Lógica_

- Na versão em `Java`, o programa segue uma lógica ligeiramente diferente:
  - nas outras linguagens [desse projeto](https://github.com/tomasfn87/calcular-digitos-verificar-cpf), o cálculo usa apenas os primeiros 9 dígitos inseridos _(ou o CPF_ *__sem__* _os dígitos verificadores)_;
  - em `Java`, ao usar o construtor da classe CPF estamos instanciando o CPF _(ou o CPF_ *__com__* _os dígitos verificadores)_.
- Ao [usar o programa por linha de comando](#executar) o número recebido é considerado um *__CPF completo__*:
  - se passarmos um número com 9 dígitos, os 2 últimos dígitos serão considerados os *__dígitos verificadores__* _(e não os 9 primeiros dígitos para então calcular os dígitos verificadores)_;
  - na prática, se não soubermos os dígitos verificadores, precisamos passar dois números quaisquer como dígitos verificadores.

### _Exemplos_

```java
Cpf cpf1 = new Cpf("1");           // IN "000.000.000-01", cálculo "000.000.000", OUT "000.000.000-00" 
Cpf cpf2 = new Cpf("100");         // IN "000.000.001-00", cálculo "000.000.001", OUT "000.000.001-91"
Cpf cpf3 = new Cpf("123456789");   // IN "001.234.567-89", cálculo "001.234.567", OUT "001.234.567-97" 
Cpf cpf4 = new Cpf("12345678901"); // IN "123.456.789-01", cálculo "123.456.789", OUT "123.456.789-09"  
```

### _Observações_

- O cálculo é feito sobre os 9 primeiros dígitos entre os 11 que compõem um CPF;
- Os 2 últimos dígitos são descartados, e, ao final do programa, o número correto é impresso;
- Se o número informado e o número calculado forem iguais, o CPF é *__válido__*.

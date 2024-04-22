# CPF - Cálculo dígitos verificadores / Verificação

## Compilador

```console
g++ (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

## Como usar

### Compilar

```console
g++ -std=c++20 -I. main.cpp cpf.cpp -o cpf
```

### Executar

#### Cálculo Dígitos Verificadores

```console
./cpf -c 123.456.789-XX
./cpf --calcular 123.456.789-XX
```

#### Formatação

```console
./cpf -f 123456789_09
./cpf --formatar 12345678990
```

#### Verificação

```console
./cpf -v 123.456.789-09
./cpf --verificar 123.456.789-90
```

#### Demo

```console
./cpf --demo
```

- A classe `Cpf` suporta comparação de objetos ignorando a formatação:
  - __Exemplo__: a comparação entre os membros `cpfComplete` com valores `"12345678909"` e `"123.456.789-09"` resultará em verdadeiro.

##### `--delete-test` option

```console
./cpf --demo --delete-test
```

- The `--delete-test` option deletes the first 3/4 objects (note the memory address changes when turning the flag on and off).

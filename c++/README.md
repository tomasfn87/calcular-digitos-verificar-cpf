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
g++ -std=c++20 -I. cpf.cpp -o cpf
```

### Executar

#### Cálculo Dígitos Verificadores

```console
./cpf -c 123.456.789-XX
./cpf --calcular 123.456.789-XX
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

##### `--delete-test` option

```console
./cpf --demo --delete-test
```

- The `--delete-test` option deletes the first 2/3 objects (note the memory address changes).

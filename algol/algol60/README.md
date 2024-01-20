# CPF

- Cálculo dígitos verificadores;
- Verificação.

---

<br><br>

## Tradutor `Algol 60` `->` `C`

```console
MARST -- Algol-to-C Translator, Version 2.7
Copyright (C) 2000, 2001, 2002, 2007, 2013 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License. This program has absolutely no warranty.
```

- Links:
  - [Página oficial GNU](https://www.gnu.org/software/marst);
  - [Download](https://ftp.gnu.org/gnu/marst/).

---

<br><br>

## Como traduzir

### De `Algol 60` `->` `C`

```console
marst cpf.a60 -o cpf.c
```

---

<br><br>

## Como compilar

### Pré-requisito: incluir caminho do `LD_LIBRARY_PATH`

```shell
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
```

> Executar o comando acima, e caso tudo funcione bem, incluir no seu arquivo de inicialização do shell (`.bashrc`, `.zshrc`, etc.).


### Usando `gcc`

```console
gcc cpf.c -lalgol -lm -o cpf
```

### Usando `zig`

```console
zig cc cpf.c -lalgol -lm -o cpf
```

---

<br><br>

## Como usar

### Calcular Dígitos CPF

```console
./cpf -c 123456789
./cpf --calcular 987654321
```

---

### Verificar CPF

```console
./cpf -v 12345678909
./cpf --verificar 98765432101
```

---

### Demo

```console
./cpf --demo
```
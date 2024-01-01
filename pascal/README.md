# CPF

- Cálculo dígitos verificadores;
- Formatação;
- Verificação.

---

## Compilador

```console
Free Pascal Compiler version 3.2.2+dfsg-9ubuntu1 [2022/04/11] for x86_64
Copyright (c) 1993-2021 by Florian Klaempfl and others
```

---

## Compilar

```console
fpc cpf.pas
```

## Como usar

## Formatar CPF

```console
./cpf -f 12345678909
./cpf --formatar 98765432100
```

---

## Calcular Dígitos CPF

```console
./cpf -c 123456789
./cpf --calcular 987654321
```

---

## Verificar CPF

```console
./cpf -v 12345678909
./cpf --verificar 98765432101
```

---

## Demo

```console
./cpf --demo
```
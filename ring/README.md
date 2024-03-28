# CPF

- Cálculo dígitos verificadores;
- Verificação.

---

## Compilador

```console
Ring version 1.19
2013-2023, Mahmoud Fayed <msfclipper@yahoo.com>
```

---

## Como usar

### Compilar

```console
ring2exe cpf.ring -dist -allruntime -noqt -noallegro
```

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

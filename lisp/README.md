# CPF

- Cálculo dígitos verificadores;
- Verificação.

---

## Interpretador

```console
SBCL 2.1.11.debian
```

---

## Como usar

### Calcular Dígitos CPF

```console
sbcl --script cpf.lisp --calcular 123456789
sbcl --script cpf.lisp -c 987654321
```

---

### Verificar CPF

```console
sbcl --script cpf.lisp --verificar 12345678909
sbcl --script cpf.lisp -v 98765432101
```

---

### Demo

```console
sbcl --script cpf.lisp --demo
```
# CPF

- Cálculo dígitos verificadores;
- Verificação.

---

## Interpretador

```console
Algol 68 Genie 2.8.4
Copyright 2016 Marcel van der Veer <algol68g@xs4all.nl>.

This is free software covered by the GNU General Public License.
There is ABSOLUTELY NO WARRANTY for Algol 68 Genie;
not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.
```

---

## Como usar

### Calcular Dígitos CPF

```console
a68g --script cpf.a68 -c 123456789
a68g --script cpf.a68 --calcular 987654321
```

---

### Verificar CPF

```console
a68g --script cpf.a68 -v 12345678909
a68g --script cpf.a68 --verificar 98765432101
```

---

### Demo

```console
a68g --script cpf.a68 --demo
```

# CPF

- Cálculo dígitos verificadores;
- Formatação;
- Verificação.

---

## Interpretador

```console
GNU Smalltalk version 3.2.5
Copyright 2009 Free Software Foundation, Inc.
Written by Steve Byrne (sbb@gnu.org) and Paolo Bonzini (bonzini@gnu.org)

GNU Smalltalk comes with NO WARRANTY, to the extent permitted by law.
You may redistribute copies of GNU Smalltalk under the terms of the
GNU General Public License.  For more information, see the file named
COPYING.
```

---

## Como usar

```console
gst cpf.st
```

## Formatar CPF

```console
gst cpf.st -f 12345678909
gst cpf.st --formatar 98765432100
```

---

## Calcular Dígitos CPF

```console
gst cpf.st -c 123456789
gst cpf.st --calcular 987654321
```

---

## Verificar CPF

```console
gst cpf.st -v 12345678909
gst cpf.st --verificar 98765432101
```

---

## Demo

```console
gst cpf.st --demo
```
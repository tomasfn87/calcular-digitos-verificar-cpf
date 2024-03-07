# CPF

- Cálculo dígitos verificadores;
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

### Dica

- Algumas distribuições linux usam um `alias` conflitante com o executável `gst` para o comando `git status`, impedindo assim a execução do `GNU/Smalltalk`;
- Para contornar esse problema, basta executar o comando abaixo:

```console
unalias gst
```

### Calcular Dígitos CPF

```console
gst cpf.st -a -c 123456789
gst cpf.st -a --calcular 987654321
```

---

### Verificar CPF

```console
gst cpf.st -a -v 12345678909
gst cpf.st -a --verificar 98765432101
```

---

### Demo

```console
gst cpf.st -a --demo
gst cpf.st --smalltalk-args --demo
```
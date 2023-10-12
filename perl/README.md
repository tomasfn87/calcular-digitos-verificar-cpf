# Calcular Dígitos / Verificar CPF

## Instalar dependência `autobox::universal` via `cpan`

```shell
cpan install autobox::universal
```

---

## Formatar CPF

```shell
perl cpf.pl -f 12345678909
perl cpf.pl --formatar 98765432100
```

---

## Calcular Dígitos CPF

```shell
perl cpf.pl -c 123456789
perl cpf.pl --calcular 987654321
```

---

## Verificar CPF

```shell
perl cpf.pl -v 12345678909
perl cpf.pl --verificar 98765432101
```

---

## Demo

```shell
perl cpf.pl --demo
```

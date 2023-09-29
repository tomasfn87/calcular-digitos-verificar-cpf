# Calcular Dígitos / Verificar CPF

<br><br>

## _Requerimentos_

### [`alr`](https://alire.ada.dev/)

```console
APPLICATION
alr version:               1.2.2
libalire version:          1.2.2
compilation date:          2023-01-12 20:53:49
compiler version:          Community 2021 (20210519-103)
```


<br><br>

## _Compilar_

```shell
alr build
```

<br><br>

## _Executar_

### Formatar CPF

```shell
./bin/cpf -f 12345678909
./bin/cpf --formatar 98765432100
```

---

### Calcular Dígitos CPF

```shell
./bin/cpf -c 123456789
./bin/cpf --calcular 987654321
```

---

### Verificar CPF

```shell
./bin/cpf -v 12345678909
./bin/cpf --verificar 98765432101
```

---

### Demo

```shell
./bin/cpf --demo
```
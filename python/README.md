# Calcular Dígitos / Verificar CPF

## Adicionar permissão de execução aos arquivos `shell script`

```
chmod +x ./*.sh
```

## Calcular Dígitos CPF

```console
./calcular_digitos_cpf.sh 123.456.789
```

---

## Verificar CPF

- *__válido__*

```console
./verificar_cpf.sh 123.456.789-09
```

- *__inválido__*

```console
./verificar_cpf.sh 123.456.789-00
```

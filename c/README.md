# CPF - Cálculo dígitos verificadores / Verificação

## Como usar

### Compilar

```console
gcc cpf.c -o cpf
```

```console
zig cc cpf.c -o cpf
```

> [`Zig`](https://ziglang.org/) é uma linguagem que ainda não possui a versão 1.0, e que ainda não é recomendada para uso em produção, mas já tem sido usada de forma experimental especialmente como compilador de bases de código em `C/C++`, devido à simplicidade no processo (_por levar em conta a necessidade de incorporar bibliotecas_ `C` _a qualquer projeto, basicamente_) e flexibilidade inerentes à linguagem, como, por exemplo, encarar a `LLVM` como um módulo, permitindo dessa forma o uso de outras biblioteca (_possivelmente mais otimizadas para uso geral ou específico_) em seu lugar ao compilar `C/C++`.

### Executar

#### Cálculo Dígitos Verificadores

```console
./cpf -c 123.456.789-XX
./cpf --calcular 123.456.789-XX
```

#### Verificação

```console
./cpf -v 123.456.789-09
./cpf --verificar 123.456.789-90
```

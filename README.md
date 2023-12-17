# calcular-digitos-verificar-cpf

_Como calcular os dígitos verificadores de um_ __CPF__; _em_ `Python`, `Typescript`, `Go`, `Rust`, `Lua`, `Java`, `C#`, `C`, `Zig`, `Ruby`, `PHP`, `Odin`, `Julia`, `Perl`, `Ada`, `Elixir`, `R`, `D` e `COBOL`.

---

<br><br>

_Teste a versão em_ `Go`:
- [CPF - Calcular Digitos / Verificar](http://bit.ly/3WYRylY)

<br><br>

## Instale a ferramenta CLI com base na versão em Python via `git clone` em sistemas `Linux`

- É necessário ter privilégios de __administrador__;
- É necessário ter o `git` instalado.

<br>

### _Instalação_

```shell
sudo git clone --depth 1 --no-checkout https://github.com/tomasfn87/calcular-digitos-verificar-cpf /usr/local/lib/calcular-digitos-verificar-cpf && pushd /usr/local/lib/calcular-digitos-verificar-cpf && sudo git sparse-checkout set python/{cpf.py,{calcular_digitos,verificar}_cpf.{py,sh}} && sudo git checkout && sudo mv python/* . && sudo chmod +x *.sh && sudo ln -rs /usr/local/lib/calcular-digitos-verificar-cpf/calcular_digitos_cpf.sh /usr/local/bin/cdcpf && sudo ln -rs /usr/local/lib/calcular-digitos-verificar-cpf/verificar_cpf.sh /usr/local/bin/vcpf && sudo rmdir python && popd && echo "\nUse os comandos vcpf e cdcpf para verificar ou calcular os dígitos de um CPF."
```

### _Desinstalação_


```shell
sudo rm -rf /usr/local/{lib/calcular-digitos-verificar-cpf,bin/{cd,v}cpf}
```

### _Atualização_

```shell
sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf && sudo git clone --depth 1 --no-checkout https://github.com/tomasfn87/calcular-digitos-verificar-cpf /usr/local/lib/calcular-digitos-verificar-cpf && pushd /usr/local/lib/calcular-digitos-verificar-cpf && sudo git sparse-checkout set python/{cpf.py,{calcular_digitos,verificar}_cpf.{py,sh}} && sudo git checkout && sudo mv python/* . && sudo chmod +x *.sh && sudo rmdir python && popd && echo "\nvcpf e cdcpf foram atualizados."
```

---

<br><br>

### Usos

- É necessário ter o `python3` instalado.

<br><br>

*__CPF__* _inválido_:
```shell
vcpf 123.456.789-08
```

<br>

*__CPF__* _válido_:
```shell
vcpf 123.456.789-09
```

<br>

_Cálculo dos Dígitos verificadores de um_ *__CPF__*:
```shell
cdcpf 123.456.789
```

<br>

_Cálculo dos Dígitos verificadores de um_ *__CPF__*:
```shell
cdcpf 123.456.789-09
```

> _Apenas os_ *__9 primeiros dígitos__* _são considerados_.

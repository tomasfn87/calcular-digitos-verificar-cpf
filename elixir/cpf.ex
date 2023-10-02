defmodule CPF do
  def reter_numeros(texto, n) when is_binary(texto) and is_integer(n) do
    apenas_nums = String.replace(texto, ~r/\D/, "")
    numeros_encontrados = String.slice(apenas_nums, 0, n)

    case String.length(numeros_encontrados) do
      0 ->
        {:ok, ""}

      len when len < n ->
        zeros_faltando = String.duplicate("0", n - len)
        {:ok, zeros_faltando <> numeros_encontrados}

      _ ->
        {:ok, numeros_encontrados}
    end
  end

  def formatar(cpf) when is_binary(cpf) do
    apenas_numeros = elem(CPF.reter_numeros(cpf, 11), 1)

    if String.length(apenas_numeros) < 1 do
      {:error, false}
    else
      dg1 = String.slice(apenas_numeros, 0, 3)
      dg2 = String.slice(apenas_numeros, 3, 3)
      dg3 = String.slice(apenas_numeros, 6, 3)
      dv = String.slice(apenas_numeros, 9, 2)

      {:ok, "#{dg1}.#{dg2}.#{dg3}-#{dv}"}
    end
  end

  def calcular_digitos_verificadores(cpf) when is_binary(cpf) do
    apenas_numeros = elem(CPF.reter_numeros(cpf, 9), 1)

    if String.length(apenas_numeros) < 1 do
      {:error, false}
    else
      primeiro_digito = calcular_digito_verificador(apenas_numeros)

      segundo_digito =
        calcular_digito_verificador(apenas_numeros <> Integer.to_string(primeiro_digito))

      {:ok, [primeiro_digito, segundo_digito]}
    end
  end

  def calcular_digito_verificador(cpf) when is_binary(cpf) do
    numeros = String.to_charlist(cpf)
    numeros_integer = Enum.map(numeros, fn char -> char - ?0 end)
    multiplicadores = for n <- (length(numeros_integer) + 1)..2, do: n

    soma =
      Enum.reduce(Enum.zip(numeros_integer, multiplicadores), 0, fn {num, mult}, acc ->
        num * mult + acc
      end)

    digito_verificador = if rem(soma, 11) < 2, do: 0, else: 11 - rem(soma, 11)
    digito_verificador
  end

  def verificar(cpf) when is_binary(cpf) do
    apenas_numeros = elem(CPF.reter_numeros(cpf, 11), 1)

    if String.length(apenas_numeros) < 1 do
      {:error, false}
    else
      cpf_sem_digitos = String.slice(apenas_numeros, 0, 9)
      digitos_recebidos = String.slice(apenas_numeros, 9, 11)

      digitos_recebidos_integer =
        Enum.map(String.to_charlist(digitos_recebidos), fn char -> char - ?0 end)

      digitos_calculados = elem(calcular_digitos_verificadores(cpf_sem_digitos), 1)

      digitos_iguais =
        Enum.all?(
          Enum.zip(digitos_recebidos_integer, digitos_calculados),
          fn {recebidos, calculados} -> recebidos == calculados end
        )

      if digitos_iguais do
        {:ok, true}
      else
        {:ok, false}
      end
    end
  end

  def cli_demo() do
    IO.puts(
      "                  reter_numeros(\"123\", 9) = \"#{elem(CPF.reter_numeros("123", 9), 1)}\""
    )

    IO.puts(
      "               reter_numeros(\"456789\", 9) = \"#{elem(CPF.reter_numeros("456789", 9), 1)}\""
    )

    IO.write("                  formatar(\"12345678909\") = ")
    IO.inspect(elem(CPF.formatar("12345678909"), 1))

    IO.write("   calcular_digitos_verificadores(\"test\") = ")
    IO.inspect(elem(CPF.calcular_digitos_verificadores("test"), 1))

    IO.write("      calcular_digitos_verificadores(\"0\") = ")
    IO.inspect(elem(CPF.calcular_digitos_verificadores("0"), 1))

    IO.write("    calcular_digitos_verificadores(\"191\") = ")
    IO.inspect(elem(CPF.calcular_digitos_verificadores("191"), 1))

    IO.write("    calcular_digitos_verificadores(\"192\") = ")
    IO.inspect(elem(CPF.calcular_digitos_verificadores("192"), 1))

    IO.write("    calcular_digitos_verificadores(\"193\") = ")
    IO.inspect(elem(CPF.calcular_digitos_verificadores("193"), 1))

    IO.write("    calcular_digitos_verificadores(\"123\") = ")
    IO.inspect(elem(CPF.calcular_digitos_verificadores("123"), 1))

    IO.write("              verificar(\"987.654.321-00\") = ")
    IO.inspect(elem(CPF.verificar("987.654.321-00"), 1))

    IO.write("              verificar(\"987.654.321-01\") = ")
    IO.inspect(elem(CPF.verificar("987.654.321-01"), 1))

    IO.write("                        verificar(\"test\") = ")
    IO.inspect(elem(CPF.verificar("test"), 1))
  end

  def cli_help() do
    IO.puts("Digite uma das opções abaixo:")

    IO.puts(
      " * '-c' ou '--calcular' e um número de CPF para calcular seus dígitos verificadores;"
    )

    IO.puts(" * '-v' ou '--verificar' e um número de CPF para verificar sua validade;")
    IO.puts(" * '-f' ou '--formatar' e um número de CPF para formatá-lo;")
    IO.puts(" * '--demo' para ver entradas e saídas das funções do programa.")
  end

  def cli_formatar(cpf) when is_binary(cpf) do
    apenas_numeros = elem(CPF.reter_numeros(cpf, 1), 1)

    if String.length(apenas_numeros) < 1 do
      IO.puts("ERRO: o CPF informado é inválido.\n")
      CPF.cli_help()
    else
      cpf_formatado = elem(formatar(cpf), 1)
      IO.puts("CPF formatado: #{cpf_formatado}")
    end
  end

  def cli_calcular_digitos_verificadores(cpf) when is_binary(cpf) do
    apenas_numeros = elem(CPF.reter_numeros(cpf, 9), 1)

    if String.length(apenas_numeros) < 1 do
      IO.puts("ERRO: o CPF informado é inválido.\n")
      CPF.cli_help()
    else
      dvs = elem(CPF.calcular_digitos_verificadores(cpf), 1)

      cpf_completo =
        apenas_numeros <> Integer.to_string(Enum.at(dvs, 0)) <> Integer.to_string(Enum.at(dvs, 1))

      IO.write("CPF informado: ")
      IO.puts(String.slice(elem(CPF.formatar(cpf_completo), 1), 0, 11))
      IO.write("CPF completo:  ")
      IO.puts(elem(CPF.formatar(cpf_completo), 1))
      IO.write("               ")
      IO.puts(elem(CPF.reter_numeros(cpf_completo, 11), 1))
      IO.inspect(dvs)
    end
  end

  def cli_verificar(cpf) when is_binary(cpf) do
    apenas_numeros = elem(CPF.reter_numeros(cpf, 1), 1)

    if String.length(apenas_numeros) < 1 do
      IO.puts("ERRO: o CPF informado é inválido.\n")
      CPF.cli_help()
    else
      valid = elem(CPF.verificar(cpf), 1)
      IO.write("O CPF #{elem(CPF.formatar(cpf), 1)} é ")

      if valid do
        IO.puts("válido.")
      else
        IO.puts("inválido.")
      end
    end
  end

  def main() do
    argv = System.argv()

    case length(argv) do
      0 ->
        CPF.cli_help()

      1 ->
        case Enum.at(argv, 0) do
        "--demo" -> CPF.cli_demo()
        _ -> CPF.cli_help()
        end

      2 ->
        case Enum.at(argv, 0) do
          "-f" -> cli_formatar(Enum.at(argv, 1))
          "--formatar" -> cli_formatar(Enum.at(argv, 1))
          "-c" -> cli_calcular_digitos_verificadores(Enum.at(argv, 1))
          "--calcular" -> cli_calcular_digitos_verificadores(Enum.at(argv, 1))
          "-v" -> cli_verificar(Enum.at(argv, 1))
          "--verificar" -> cli_verificar(Enum.at(argv, 1))
          _ -> CPF.cli_help()
        end

      _ ->
        CPF.cli_help()
    end
  end
end

CPF.main()

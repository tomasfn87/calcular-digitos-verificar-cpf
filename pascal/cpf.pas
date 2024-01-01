program Cpf;

uses
    SysUtils;

type
    TypeDVs = record
        DV1, DV2: Integer;
end;

function PadWithZeros(input: String; desiredLength: Integer): String;
begin
    PadWithZeros := StringOfChar('0', desiredLength - Length(input)) + input
end;

function ReterNumeros(input: String; n: Integer): String;
var
    i: Integer;
    count: Integer = 0;
    result: String = '';
begin
    for i := 1 to Length(input) do
    begin
        if input[i] in ['0'..'9'] then
        begin
           Inc(count);
           result := result + input[i];
           if count = n then
               break;
        end;
    end;

    if (Length(result) > 0) and (Length(result) < n) then
        result := PadWithZeros(result, n);

    ReterNumeros := result;
end;

function CalcularDigitos(cpf: String): TypeDVs;
var
    numsCpf: String;
    dvs: TypeDVs;
    fator: Integer = 10;
    resto: Integer = 0;
    soma: Integer = 0;
    i: Integer;
begin
    dvs.DV1 := 0;
    dvs.DV2 := 0;
    numsCpf := ReterNumeros(cpf, 9);
    if Length(numsCpf) = 0 then
    begin
        writeln('ERRO: o CPF informado não possui nenhum número.');
        Halt;
    end;

    for i := 1 to Length(numsCpf) do
    begin
        soma := soma + StrToInt(numsCpf[i]) * fator;
        Dec(fator);
    end;
    resto := soma mod 11;
    if resto > 1 then
    begin
        dvs.DV1 := 11 - resto;
    end;

    fator := 11;
    soma := 0;
    for i := 1 to Length(numsCpf) do
    begin
        soma := soma + StrToInt(numsCpf[i]) * fator;
        Dec(fator);
    end;
    soma := soma + dvs.DV1 * fator;
    resto := soma mod 11;
    if resto > 1 then
    begin
        dvs.DV2 := 11 - resto;
    end;

    CalcularDigitos := dvs;
end;

function Verificar(cpf: String): Boolean;
var
    numsCpf: String;
    dvsRecebidos: TypeDVs;
    dvsCalculados: TypeDVs;
begin
    numsCpf := ReterNumeros(cpf, 11);
    if Length(numsCpf) = 0 then
    begin
        writeln('ERRO: o CPF informado não possui nenhum número.');
        Halt;
    end;
    dvsRecebidos.DV1 := StrToInt(numsCpf[10]);
    dvsRecebidos.DV2 := StrToInt(numsCpf[11]);
    dvsCalculados := CalcularDigitos(Copy(numsCpf, 1, 9));
    if (dvsRecebidos.DV1 = dvsCalculados.DV1)
       and (dvsRecebidos.DV2 = dvsCalculados.DV2) then
        Verificar := True
    else
        Verificar := False;
end;

function Formatar(cpf: String): String;
var
    numsCpf: String;
begin
    numsCpf := ReterNumeros(cpf, 11);
    if Length(numsCpf) = 0 then
    begin
        writeln('ERRO: o CPF informado não possui nenhum número.');
        Halt;
    end;
    Formatar := Format('%s.%s.%s-%s', [
        Copy(numsCpf, 1, 3), Copy(numsCpf, 4, 3),
        Copy(numsCpf, 7, 3), Copy(numsCpf, 10, 2)]);
end;

procedure PrintHelp();
begin
    writeln('Escolha uma das opções abaixo como argumento(s) de linha de comando:');
    writeln(' * "--c" ou "--calcular" e um número de CPF;');
    writeln(' * "--f" ou "--formatar" e um número de CPF;');
    writeln(' * "--v" ou "--verificar" e um número de CPF;');
    writeln(' * "--demo".');
end;

procedure Main();
var
    dvs1: TypeDVs;
    dvs2: TypeDVs;
    isValid: Boolean;
begin
    if ParamCount = 0 then
    begin
        PrintHelp();
        Halt;
    end;

    if ParamStr(1) = '--demo' then
    begin
        writeln('ReterNumeros("Hello, world!", 1) -> "',
            ReterNumeros('Hello, world!', 1), '"');
        writeln('            ReterNumeros("1", 2) -> "',
            ReterNumeros('1', 2), '"');
        writeln('          ReterNumeros("123", 2) -> "',
            ReterNumeros('123', 2), '"');

        writeln();
        writeln('               Formatar("19291") -> ',
            Formatar('19291'));

        writeln();
        dvs1 := CalcularDigitos('123');
        writeln('          CalcularDigitos("123") -> ( ',
            dvs1.DV1, ', ', dvs1.DV2, ' )');
        dvs2 := CalcularDigitos('192');
        writeln('          CalcularDigitos("192") -> ( ',
            dvs2.DV1, ', ', dvs2.DV2, ' )');

        writeln();
        writeln('              Verificar("19291") -> ',
            Verificar('19291'));
        writeln('              Verificar("12370") -> ',
            Verificar('12370'));
        writeln('     Verificar("000.000.000-00") -> ',
            Verificar('000.000.000-00'));
        writeln('     Verificar("111.444.777-35") -> ',
            Verificar('111.444.777-35'));
        writeln('               Verificar("test") -> ',
            Verificar('test'));
        Halt;
    end;
    
    if (ParamCount < 2) or (Length(ReterNumeros(ParamStr(2), 1)) = 0) then
    begin
        PrintHelp();
        Halt;
    end;

    if (ParamStr(1) = '-c') or (ParamStr(1) = '--calcular') then
    begin
        dvs1 := CalcularDigitos(ParamStr(2));
        writeln('CPF recebido:  ', Copy(
            Formatar(ReterNumeros(ParamStr(2), 9) + '00'), 1, 11));
        writeln('CPF calculado: ', Formatar(Format(
            '%s%d%d', [ReterNumeros(ParamStr(2), 9), dvs1.DV1, dvs1.DV2])));
        writeln('               ', Format(
            '%s%d%d', [ReterNumeros(ParamStr(2), 9), dvs1.DV1, dvs1.DV2]));
        writeln('( ', dvs1.DV1, ', ', dvs1.DV2, ' )');
    end
    else
    if (ParamStr(1) = '-f') or (ParamStr(1) = '--formatar') then
    begin
        writeln('CPF formatado: ', Formatar(ParamStr(2)));
    end
    else
    if (ParamStr(1) = '-v') or (ParamStr(1) = '--verificar') then
    begin
        write('O CPF ', Formatar(ParamStr(2)), ' é ');
        isValid := Verificar(ParamStr(2));
        if isValid then
            writeln('válido.')
        else
            writeln('inválido.');
    end;
end;

begin
    Main();
end.
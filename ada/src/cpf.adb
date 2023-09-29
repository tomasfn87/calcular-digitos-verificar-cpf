with Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Cpf is
   type DVs is array (1 .. 2) of Natural;

   function Reter_Numeros (Texto : String; N : Natural) return String is
      Apenas_Numeros : Ada.Strings.Unbounded.Unbounded_String :=
        Ada.Strings.Unbounded.Null_Unbounded_String;
      Cont           : Natural                                := 0;
   begin
      for i in Texto'Range loop
         declare
            Char_Code : constant Integer := Character'Pos (Texto (i));
         begin
            if Cont = N then
               exit;
            end if;
            if Char_Code > 47 and then Char_Code < 58 then
               Ada.Strings.Unbounded.Append (Apenas_Numeros, Texto (i));
               Cont := Cont + 1;
            end if;
         end;
      end loop;
      if Cont = 0 then
         return "";
      end if;
      while Ada.Strings.Unbounded.Length (Apenas_Numeros) /= N loop
         begin
            Apenas_Numeros := "0" & Apenas_Numeros;
         end;
      end loop;
      return Ada.Strings.Unbounded.To_String (Apenas_Numeros);
   end Reter_Numeros;

   function Calcular_Digitos (CPF : String) return DVs is
      Digitos_Verificadores : DVs              := (0, 0);
      Num_Digitos_Base      : constant Natural := 9;
      Apenas_Numeros_CPF    : constant String  :=
        Reter_Numeros (CPF, Num_Digitos_Base);
      Soma                  : Natural          := 0;
      Multiplicador         : Natural          := Num_Digitos_Base + 1;
      Resto                 : Natural          := 0;
   begin
      for i in Apenas_Numeros_CPF'Range loop
         declare
            Natural_Value : constant Natural :=
              Character'Pos (Apenas_Numeros_CPF (i)) - Character'Pos ('0');
         begin
            Soma          := Soma + (Natural_Value * Multiplicador);
            Multiplicador := Multiplicador - 1;
         end;
      end loop;
      Resto := Soma rem (Num_Digitos_Base + 2);
      if Resto > 1 then
         Digitos_Verificadores (1) := (Num_Digitos_Base + 2) - Resto;
      end if;
      Soma          := 0;
      Multiplicador := Num_Digitos_Base + 2;
      for i in Apenas_Numeros_CPF'Range loop
         declare
            Natural_Value : constant Natural :=
              Character'Pos (Apenas_Numeros_CPF (i)) - Character'Pos ('0');
         begin
            Soma          := Soma + (Natural_Value * Multiplicador);
            Multiplicador := Multiplicador - 1;
         end;
      end loop;
      Soma  := Soma + (Digitos_Verificadores (1) * Multiplicador);
      Resto := Soma rem (Num_Digitos_Base + 2);
      if Resto > 1 then
         Digitos_Verificadores (2) := (Num_Digitos_Base + 2) - Resto;
      end if;
      return Digitos_Verificadores;
   end Calcular_Digitos;

   function Verificar (CPF : String) return Boolean is
      Apenas_Numeros_CPF : constant String := Reter_Numeros (CPF, 11);
      DVs_Recebidos      : constant DVs    :=
        Calcular_Digitos (Apenas_Numeros_CPF (1 .. 9));
      DVs_Calculados     : DVs             := (0, 0);
   begin
      DVs_Calculados (1) :=
        Character'Pos (Apenas_Numeros_CPF (10)) - Character'Pos ('0');
      DVs_Calculados (2) :=
        Character'Pos (Apenas_Numeros_CPF (11)) - Character'Pos ('0');
      if DVs_Calculados (1) = DVs_Recebidos (1)
        and then DVs_Calculados (2) = DVs_Recebidos (2)
      then
         return True;
      end if;
      return False;
   end Verificar;

   function Formatar (CPF : String) return String is
      Apenas_Numeros_CPF : constant String := Reter_Numeros (CPF, 11);
      CPF_Formatado      : String (1 .. 14);
   begin
      CPF_Formatado :=
        Apenas_Numeros_CPF (1 .. 3) & "." & Apenas_Numeros_CPF (4 .. 6) & "." &
        Apenas_Numeros_CPF (7 .. 9) & "-" & Apenas_Numeros_CPF (10 .. 11);
      return CPF_Formatado;
   end Formatar;

   function Imprimir_DVs (Arr : DVs) return String is
      Result : Ada.Strings.Unbounded.Unbounded_String :=
        Ada.Strings.Unbounded.To_Unbounded_String ("(");
   begin
      for i in Arr'Range loop
         Ada.Strings.Unbounded.Append (Result, Natural'Image (Arr (i)));
         if i /= Arr'Last then
            Ada.Strings.Unbounded.Append (Result, ",");
         else
            Ada.Strings.Unbounded.Append (Result, " ");
         end if;
      end loop;
      Ada.Strings.Unbounded.Append (Result, ")");
      return Ada.Strings.Unbounded.To_String (Result);
   end Imprimir_DVs;

begin
   Ada.Text_IO.Put_Line
     ("Verificar (""123.456.789-09"") = " &
      Boolean'Image (Verificar ("123.456.789-09")));
   Ada.Text_IO.Put_Line
     ("Verificar (""123.456.789-08"") = " &
      Boolean'Image (Verificar ("123.456.789-08")));
   Ada.Text_IO.Put_Line
     ("Calcular_Digitos (""123.456.789"") = " &
      Imprimir_DVs (Calcular_Digitos ("123.456.789")));
   Ada.Text_IO.Put_Line
     ("Calcular_Digitos (""123"") = " &
      Imprimir_DVs (Calcular_Digitos ("123")));
   Ada.Text_IO.Put_Line
     ("Formatar (""12345678909"") = " & Formatar ("12345678909"));
   Ada.Text_IO.Put_Line ("Formatar (""12360"") = " & Formatar ("12360"));
   Ada.Text_IO.Put_Line
     ("Reter_Numeros (""test123"", 2)" & " = """ &
      Reter_Numeros ("test123", 2) & """");
   Ada.Text_IO.Put_Line
     ("Reter_Numeros (""test123"", 1)" & " = """ &
      Reter_Numeros ("test123", 1) & """");
   Ada.Text_IO.Put_Line
     ("Reter_Numeros (""test1"", 2)" & " = """ & Reter_Numeros ("test1", 2) &
      """");
   Ada.Text_IO.Put_Line
     ("Reter_Numeros (""test"", 1)" & " = """ & Reter_Numeros ("test", 1) &
      """");
end Cpf;

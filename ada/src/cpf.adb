with Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Cpf is
   type DVs is array (1 .. 2) of Natural;

   function Reter_Numeros (Texto : String; N : Natural) return String is
      Apenas_Numeros : Ada.Strings.Unbounded.Unbounded_String :=
         Ada.Strings.Unbounded.Null_Unbounded_String;
      Cont : Natural := 0;
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
      Digitos_Verificadores : DVs := (0, 0);
      Num_Digitos_Base : constant Natural := 9;
      Apenas_Numeros_CPF : String := Reter_Numeros (CPF, Num_Digitos_Base);
      Soma : Natural := 0;
      Multiplicador : Natural := Num_Digitos_Base + 1;
      Resto : Natural := 0;
   begin
      for i in Apenas_Numeros_CPF'Range loop
         begin
            Soma := Soma +
               ((Character'Pos (Apenas_Numeros_CPF (i))
               - Character'Pos ('0')) * Multiplicador);
            Multiplicador := Multiplicador - 1;
         end;
      end loop;
      Resto := Soma rem (Num_Digitos_Base + 2);
      if Resto > 1 then
         Digitos_Verificadores(1) := (Num_Digitos_Base + 2) - Resto;
      end if;
      Soma := 0;
      Multiplicador := Num_Digitos_Base + 2;
      for i in Apenas_Numeros_CPF'Range loop
         begin
            Soma := Soma +
               ((Character'Pos (Apenas_Numeros_CPF (i))
               - Character'Pos ('0')) * Multiplicador);
            Multiplicador := Multiplicador - 1;
         end;
      end loop;
      Soma := Soma + (Digitos_Verificadores (1) * Multiplicador);
      Resto := Soma rem (Num_Digitos_Base + 2);
      if Resto > 1 then
         Digitos_Verificadores (2) := (Num_Digitos_Base + 2) - Resto;
      end if;
      return Digitos_Verificadores;
   end Calcular_Digitos;

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
   Ada.Text_IO.Put_Line ("Calcular_Digitos (""123.456.789"") = " &
      Imprimir_DVs (Calcular_Digitos ("123.456.789")));
   Ada.Text_IO.Put_Line ("Calcular_Digitos (""123"") = " &
      Imprimir_DVs (Calcular_Digitos ("123")));
   Ada.Text_IO.Put_Line ("Reter_Numeros (""test123"", 2)" &
      " = """ & Reter_Numeros ("test123", 2) & """");
   Ada.Text_IO.Put_Line ("Reter_Numeros (""test123"", 1)" &
      " = """ & Reter_Numeros ("test123", 1) & """");
   Ada.Text_IO.Put_Line ("Reter_Numeros (""test1"", 2)" &
      " = """ & Reter_Numeros ("test1", 2) & """");
   Ada.Text_IO.Put_Line ("Reter_Numeros (""test"", 1)" &
      " = """ & Reter_Numeros ("test", 1) & """");
end Cpf;

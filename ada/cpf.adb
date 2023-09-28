with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Cpf is
   procedure Reter_Numeros (Texto: String; N: Natural) is
      Apenas_Numeros : Ada.Strings.Unbounded.Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      Cont : Natural := 0;
   begin
      for i in Texto'Range loop
         declare
            Char_Code : constant Integer := Character'Pos(Texto(i));
         begin
            if Cont = N then
               exit;
            end if;
            if Char_Code > 47 and Char_Code < 58 then
               Ada.Strings.Unbounded.Append(Apenas_Numeros, Texto(i));
               Cont := Cont + 1;
            end if;
         end;
      end loop;
      Ada.Text_IO.Put_Line("Números retidos de """ & Texto & """ = """ & Ada.Strings.Unbounded.To_String(Apenas_Numeros) & """");
   end Reter_Numeros;
begin
   Reter_Numeros("test123", 2);
   Reter_Numeros("test1", 1);
   Reter_Numeros("test", 1);
end Cpf;

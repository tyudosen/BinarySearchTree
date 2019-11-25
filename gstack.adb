with Ada.Text_IO; use Ada.Text_IO;
package body gstack is
    Stack : entries; 
    top: integer range 0.. Max;

    procedure Push(X: in item) is
    begin
          Top := Top + 1;
          Stack(Top) := X;
    end push;

    procedure Pop(X: out item) is
    begin
        X := Stack(Top);
        Top := Top - 1;
    end Pop;

    function Empty return boolean is
    begin
        if top = 0 then
            return True;
        else
            return False;
        end if;
    end Empty;

begin
    Top := 0; 
end gstack;
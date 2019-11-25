generic
    Max: integer;
    type item is private; -- type of stack

package gstack is
    procedure Push(x: in item);
    procedure Pop(x: out item);
    function Empty return boolean;
private
    type entries is array( 1..Max) of item;
    
end gstack;



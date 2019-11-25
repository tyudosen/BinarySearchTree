with Ada.Text_IO; use Ada.Text_IO;
with binary_search_tree; use binary_search_tree;

procedure driver is
    --type string10 is new String(1..10);
    type customer is record
      name  : string10;
      phone : string10;
    end record;


   function "<" (Thekey : in string10; Arecord : customer) return boolean is
   begin
      if thekey < Arecord.name then
         return true;
      else
         return false;
      end if;
   end;

   function ">" (Thekey : in string10; Arecord : customer) return boolean is
   begin
      if thekey > Arecord.name then
         return true;
      else
         return false;
      end if;
   end;

   function "=" (Thekey : in string10; Arecord : customer) return boolean is
   begin
      if thekey = Arecord.name then
        return true;
      else
         return false;
      end if;
   end;

   procedure Get(Str: in out string10 ) is 
      Knt: Integer;
   begin
      get_line(Str,Knt);
      Str(Knt + 1.. Str'Last) := ( OTHERS => ' ');

   end Get;
package MySearchTree is new binary_search_tree.nested_generic(string10, customer, "<", ">", "=", Get); use MySearchTree;

Pt, CustPoint, Succ,succ1,SuccPtr, SuccPtr1: BinarySearchTreePoint;
Temp, Temp1 : customer;
Knt : Integer := 0;
a : string10;
flag : string10; 
flag1 : string10;

begin
AllocateNode(Pt, "          ", "          ");
------------------------------------------------------------------------

   --Insert the following data in the tree using InsertBinarySearchTree: 
   --Moutafis, 295-1492;
   --Ikerd, 291-1864;  
   --Gladwin, 295-1601;  
   --Robson, 293-6122;  
   --Dang, 295-1882;  
   --Bird,  291-7890;  
   --Harris, 294-8075; 
   --Ortiz, 584-3622.
   -------------------------------------------------------
   InsertBinarySearchTree(Pt, "Moutafis  ", "259-1492  ");
   InsertBinarySearchTree(Pt, "Ikerd     ", "291-1864  ");
   InsertBinarySearchTree(Pt, "Gladwin   ", "295-1601  ");
   InsertBinarySearchTree(Pt, "Robson    ", "293-6122  ");
   InsertBinarySearchTree(Pt, "Dang      ", "295-1882  ");
   InsertBinarySearchTree(Pt, "Bird      ", "291-7890  ");
   InsertBinarySearchTree(Pt, "Harris    ", "294-8075  ");
   InsertBinarySearchTree(Pt, "Ortiz     ", "584-3622  ");
   --------------------------------------------------------
  
   --Find Ortiz and print the phone number using FindCustomerIterative.
   FindCustomerIterative(Pt, "Ortiz     ", CustPoint);
   put_line("Name: " & CustomerName(CustPoint) & "Phone: " & CustomerPhone(CustPoint));
   put_line("---------------------------------------------------------------------");

   --Find Ortiz and print the phone number using FindCustomerRecursive
   FindCustomerRecursive(Pt, "Ortiz     ", CustPoint);
   put_line("Name: " & CustomerName(CustPoint) & "Phone: " & CustomerPhone(CustPoint));
   put_line("---------------------------------------------------------------------");

   --Find Penton and print the phone number using FindCustomerIterative.
   FindCustomerIterative(Pt, "Penton    ", CustPoint);
   put_line("Name: " & CustomerName(CustPoint) & "Phone: " & CustomerPhone(CustPoint));
   put_line("---------------------------------------------------------------------");

	--Find Penton and print the phone number using FindCustomerRecursive.
   FindCustomerRecursive(Pt, "Penton    ", CustPoint);
   put_line("Name: " & CustomerName(CustPoint) & "Phone: " & CustomerPhone(CustPoint));
   put_line("---------------------------------------------------------------------");

   new_line;
   FindCustomerRecursive(Pt, "Ikerd     ", CustPoint);
   InOrder(CustPoint);

   InsertBinarySearchTree(Pt, "Avila     ", "259-1492  ");
   InsertBinarySearchTree(Pt, "Quijada   ", "291-1864  ");
   InsertBinarySearchTree(Pt, "Villatoro ", "293-6122  ");

   new_line;
   put_line("Inorder Traversal");
   InOrder(Pt);

   new_line;
   put_line("PreOrder Traversal");
   PreOrder(Pt);

   new_line;
   put_line("PostOrderIterative");
   PostOrderIterative(Pt);




  
end driver;
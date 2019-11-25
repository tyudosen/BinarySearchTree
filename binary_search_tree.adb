with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with gstack;
package body binary_search_tree is
    
    procedure Free is new Ada.Unchecked_Deallocation(Node,BinarySearchTreePoint);
package body nested_generic is

    Count : Integer := 0;

    procedure AllocateNode(Q: out BinarySearchTreePoint; CustName: String10; CustPhone: String10) is
    begin
        Q := new Node;
        Q.Info.Name := CustName;
        Q.Info.Phone := CustPhone;
        Q.Llink := null;
        Q.Ltag := False;
        Q.Rlink := null;
        Q.Rtag := False;
    end AllocateNode;

	procedure InsertNode(P,Q: out BinarySearchTreePoint; CustName: String10) is 
    begin
        if CustName < P.Info.Name then
            P.Llink := Q; -- Insert CustName as left subtree of P.
        else    
            P.Rlink := Q; -- Insert CustName as right subtree of P.
        end if;
    end InsertNode;

    procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint;CustName: in String10; CustPhone: in String10 ) is
        Pt, P1 : BinarySearchTreePoint;
       
    begin
        if Root = null then
            AllocateNode(Pt, CustName, CustPhone);
            Root := Pt;
        else
            P1 := Root;
            loop -- search left and right for a match or insert in tree if not found.
                if "<"(CustName,P1.Info.Name) then-- Search Left
                    if P1.Llink /= null then--P1.Llink /= null then
                        P1 := P1.Llink;
                    else
                        AllocateNode(Pt, CustName, CustPhone); -- Insert node as left subtree.
                        InsertNode(P1, Pt, CustName);
                        Count := Count + 1;
                        exit; -- New node inserted
                    end if;
                elsif ">"(CustName, P1.Info.Name) then--CustName > P1.Info.Name then -- Search Right
                    if P1.Rlink /= null then --P1.Rlink /= null then
                        P1 := P1.Rlink;
                    else
                        AllocateNode(Pt, CustName, CustPhone); -- Insert node as left subtree.
                        InsertNode(P1, Pt, CustName);
                        Count := Count + 1;
                        exit; -- New node inserted
                    end if;
                else 
                    --InsertNode(P1,Pt,CustName);
                    exit;
                end if;
            end loop;
        end if;
        
    end InsertBinarySearchTree;

   

    procedure FindCustomerIterative(Root: in out BinarySearchTreePoint;CustName:  in String10; CustomerPoint: out BinarySearchTreePoint) is
        Pt: BinarySearchTreePoint := Root;
    begin
        loop
            if Root = null then -- Empty Tree
                Pt := Root;
                put("Empty Tree");
                CustomerPoint := Pt;
                exit;
            end if;
            if Pt /= null then -- Tree has n > 0 nodes 
                if ">"(CustName, Pt.Info.Name) then -- Search right 
                    Pt := Pt.Rlink;
                elsif "<"(CustName, Pt.Info.Name) then -- Seasrch left.
                    Pt := Pt.Llink;
                else -- Implies key has been found.
                    CustomerPoint := Pt; -- Return pointer of found key.
                    put_line("--------------------------------------");
                    exit;
                end if;
            else -- Key not in tree.
                --put(Pt.Info.Name);
                --put("Customer is not on record");new_line;
                CustomerPoint := Pt;
                exit;

            end if;


        end loop;
        
    end FindCustomerIterative;

    procedure FindCustomerRecursive(Root: in BinarySearchTreePoint;CustName: in String10; CustomerPoint:  out BinarySearchTreePoint) is
        Pt : BinarySearchTreePoint;
    begin
        if Root /= null then
            Pt := Root;
            if "="(Pt.info.name,CustName) then
                CustomerPoint := Pt;
            elsif Pt.Info.Name <= CustName then
                FindCustomerRecursive(Pt.Rlink, CustName,Customerpoint);
            else
                FindCustomerRecursive(Pt.llink, CustName,customerpoint);
            end if;
        else
            Customerpoint := Pt;
        end if;
    end FindCustomerRecursive;

    function InOrderSuccessor(TreePoint: in BinarySearchTreePoint; Succ: in out BinarySearchTreePoint) return BinarySearchTreePoint is
        Pt, P1: BinarySearchTreePoint; 
    begin
       Pt := TreePoint; -- Points to a node in tree
       P1 := Pt.Rlink; -- Look right
       if Pt.Rtag = False then
            Pt := P1;
            Succ := Pt;
       else
            while P1.Ltag = True loop
                P1 := P1.Llink;
            end loop;
            Pt := P1;
            Succ := Pt;
       end if;
        return Pt;

    end InOrderSuccessor;

    function CustomerName(TreePoint: in BinarySearchTreePoint) return String10 is
    begin
        if TreePoint = null then
            return "Null      ";
        else
            return TreePoint.Info.Name;
        end if;
    end CustomerName;

	function CustomerPhone(TreePoint: in BinarySearchTreePoint) return String10 is
    begin
        if TreePoint = null then
            return "Null      ";
        else
            return TreePoint.Info.Phone;
        end if;
    end CustomerPhone;

    procedure Inorder(TreePoint: in BinarySearchTreePoint) is 
        package Stack is new gstack(20, BinarySearchTreePoint); use Stack;
        Pt, P1 : BinarySearchTreePoint;
    begin
        Pt := TreePoint;
        loop
            IF Pt /= null then
                Push(Pt);
                Pt := Pt.Llink;
            else
                IF Empty = True then
                    exit;
                else
                    Pop(P1);
                    put_line(P1.info.name & P1.info.phone);
                    pt := P1.rlink;
                end if;
            end if;
        end loop;
    end Inorder;


    procedure PreOrder(TreePoint: in out BinarySearchTreePoint) is 
    package Stack is new gstack(20, BinarySearchTreePoint); use Stack;
    Pt, P1 : BinarySearchTreePoint;
    begin
        Pt := TreePoint;
        loop
            if Pt /= null then
                put_line("Name: " & CustomerName(Pt) & "Phone: " & CustomerPhone(Pt) );
                push(Pt);
                Pt := Pt.Llink;
            else
                if empty = True then
                    exit;
                else
                    pop(P1);
                    Pt := P1.Rlink;
                end if;
            end if;
            
        end loop;
    end PreOrder;

    procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint) is
        package Stack is new gstack(20,BinarySearchTreePoint);
        use Stack;
        type tree is record
            Ptr: BinarySearchTreePoint;
            Dir: Integer range 0..1;
        end record;
        Rec : tree;
        package TreeStack is new gstack(20,Tree);
        Pt,P1 : BinarySearchTreePoint;
        Count, Trav : Integer;
    begin
        Count := 0;
        Pt := TreePoint;
        loop
            if Pt /= null then
                Count := Count + 1;
                Rec.Ptr := Pt;
                Rec.Dir := 0;
                TreeStack.Push(Rec);
                Pt := Pt.Llink;
            else
                exit when Count = 0;
                TreeStack.Pop(Rec);
                Pt := Rec.Ptr;
                Trav := Rec.Dir;
                Count := Count -1;
                if Trav = 0 then
                    Count := Count + 1;
                    Rec.Ptr := Pt;
                    Rec.Dir := 1;
                    TreeStack.Push(Rec);
                    Pt := Pt.Rlink;
                else
                    loop
                        put_line("Name: " & CustomerName(Pt) & "Phone: " & CustomerPhone(Pt) );
                        exit when Count = 0;
                        TreeStack.Pop(Rec);
                        Pt := Rec.Ptr;
                        Trav := Rec.Dir;
                        Count := Count -1;
                        if Trav = 0 then
                            Count := Count + 1;
                            Rec.Ptr := Pt;
                            Rec.Dir := 1;
                            TreeStack.Push(Rec);
                            Pt := Pt.Rlink;
                        end if;
                        exit when Trav = 0;
                    end loop;

                end if;
            end if;
            exit when Count = 0;
        end loop;
        
    end PostOrderIterative;
        


    procedure ReverseInorder(TreePoint: in BinarySearchTreePoint) is 
    package Stack is new gstack(20, BinarySearchTreePoint); use Stack;
    Pt, P1 : BinarySearchTreePoint;
    begin
        Pt := TreePoint;
        if Pt /= null then
            ReverseInorder(Pt.Rlink); put_line(CustomerName(Pt));
            ReverseInorder(Pt.Llink);
        end if;
    end ReverseInorder;



end nested_generic;
end binary_search_tree;
package binary_search_tree is
	type BinarySearchTreePoint is private; -- (note: figure out how to make limited)

	subtype String10 is string(1..10);
	generic
		type Akey is private;
		type BinarySearchTreeRecord is private;
		-- These functions compare two nodes in the tree.
    	with function "<" (TheKey: in Akey; ARecord: in BinarySearchTreeRecord) return Boolean; -- Is TheKey less than the key of ARecord?
		with function ">" (TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord) return Boolean;
		with function "=" (TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord) return Boolean;
		with procedure get(Str: in out String10);  --Is TheKey equal to the key of ARecord?
	package nested_generic is


		--function createNode(Root: in BinarySearchTreePoint) return BinarySearchTreePoint;
		--procedure HeadNode(Root: in out BinarySearchTreePoint);
		procedure AllocateNode(Q: out BinarySearchTreePoint; CustName: String10; CustPhone: String10);
		procedure InsertNode(P,Q: out BinarySearchTreePoint; CustName: String10);
		-- This procedure inserts a node (customer) into the tree in search tree order. If a customer with 
    	-- duplicate name already customer exist, the new customer should be inserted so they would 
    	-- appear “after” the older customer when the tree is traversed in inorder.
		-- The tree must be threaded in “inorder.”  The search to locate the position for the new 
    	-- record must be iterative!
		procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint;CustName: in String10; CustPhone: in String10 );

		--procedure DeleteBinarySearchTree(Root: in out BinarySearchTreePoint; CustName: in String10);

		-- This procedure locates a customer using a binary search.  A pointer is returned to the
    	-- customer record if they exist, otherwise a Null pointer is returned (in CustomerPoint).
		-- The search must be implemented iteratively.
		procedure FindCustomerIterative(Root: in out BinarySearchTreePoint;CustName:  in String10; CustomerPoint:  out BinarySearchTreePoint);
	
		-- This procedure locates a customer using a binary search.  A pointer is returned to the
    	-- customer record if they exist, otherwise a Null pointer is returned (in CustomerPoint).
		-- The search must be implemented recursively.
		procedure FindCustomerRecursive(Root: in BinarySearchTreePoint;CustName: in String10; CustomerPoint:  out BinarySearchTreePoint);
	

		-- This function returns the address of the next node in “inorder.”  The user may enter the 
		-- tree at any random location.  This is sometimes called an iteration function 
    	-- (no recursion).
		function InOrderSuccessor(TreePoint: in BinarySearchTreePoint; Succ: in out BinarySearchTreePoint) return BinarySearchTreePoint;
		--function InOrderPredecessor(TreePoint: in BinarySearchTreePoint) return BinarySearchTreePoint;

		-- Access functions to return customer names and phone numbers.
		function CustomerName(TreePoint: in BinarySearchTreePoint) return String10;
		function CustomerPhone(TreePoint: in BinarySearchTreePoint) return String10;


		-- Iterative procedure utilizing threads that prints the name fields of the tree in preorder
    	-- from within the procedure as it traverses the nodes.  
		procedure PreOrder(TreePoint: in out BinarySearchTreePoint);

		--Procedure to traverse the tree utilizing threads printing the name fields.
		--You may assume traversal will always start at the root.
		procedure Inorder(TreePoint: in BinarySearchTreePoint);--procedure InOrder(TreePoint: in out BinarySearchTreePoint);
		procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint);
		procedure ReverseInOrder(treePoint: in BinarySearchTreePoint);
    end nested_generic;
	private
		type CustRec is record
			Name: String10;
			Phone: String10;
		end record;

		type Node;
		type BinarySearchTreePoint is access Node;
		type Node is record
			Llink, Rlink:  BinarySearchTreePoint;
			Ltag, Rtag:  Boolean;  -- True indicates pointer to lower level, False a thread.
			Info:  CustRec;
		end record;
end binary_search_tree;
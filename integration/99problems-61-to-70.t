use v6;
use Test;
plan 15;

{
    # P61 (*) Count the leaves of a binary tree
    
    # A leaf is a node with no successors. 
    # Write a predicate count_leaves/2 to count them.
    #
    #  % count_leaves(T,N) :- the binary tree T has N leaves
    
    # only 'C' and 'D' are leaves
    my $tree = ['A', ['B', ['C', Any, Any], ['D', Any, Any]], Any];
    
    sub count_leaves($tree){
        return 0 unless defined($tree);
        return 1 if (not defined($tree[1])) and (not defined($tree[2]));
        return count_leaves($tree[1]) + count_leaves($tree[2]);
    }
    
    is(count_leaves($tree), 2, "count_leaves works");
}

{
    # P61A (*) Collect the leaves of a binary tree in a list
    # 
    # A leaf is a node with no successors. Write a predicate leaves/2 to collect them
    # in a list.
    # 
    # % leaves(T,S) :- S is the list of all leaves of the binary tree T
    
    # the spec does not specify if the tree should be flattened in pre/infix or
    # postfix order, let's just assue prefix or infix

    my $tree = ['A', ['B', ['C', Any, Any], ['D', Any, Any]], Any];
    
    my @expected = ('C', 'D');
    
    sub leaves($tree){
        return () unless defined($tree);
        return ($tree[0],) if (not defined($tree[1])) and (not defined($tree[2]));
        return leaves($tree[1]), leaves($tree[2]);
    }
    
    is(leaves($tree), @expected, "leaves() works");
}

{
    #P62 (*) Collect the internal nodes of a binary tree in a list
    
    # An internal node of a binary tree has either one or two non-empty 
    # successors. Write a predicate internals/2 to collect them in a list.
    #
    #    % internals(T,S) :- S is the list of internal nodes of the binary tree T.
     
    my $tree = ['A', ['B', ['C', Any, Any], ['D', Any, Any]], ['E', Any, Any]];
    
    my @expected = ('A', 'B');
    
    # assume preorder traversal
    
    sub internals($tree){
        return () unless defined($tree);
        if defined($tree[1]) and defined($tree[2]) {
            gather {
                take $tree[0];
                take internals($tree[1]); 
                take internals($tree[2]);
            }
        } else {
            gather { 
                take internals($tree[1]); 
                take internals($tree[2]);
            }
        }
    }
    
    is(internals($tree), @expected, "internals() collects internal nodes");
    
    # P62B (*) Collect the nodes at a given level in a list
    # 
    # A node of a binary tree is at level N if the path from the root to the node has
    # length N-1. The root node is at level 1. Write a predicate atlevel/3 to collect
    # all nodes at a given level in a list.
    # 
    # % atlevel(T,L,S) :- S is the list of nodes of the binary tree T at level L
    # 
    # Using atlevel/3 it is easy to construct a predicate levelorder/2 which creates
    # the level-order sequence of the nodes. However, there are more efficient ways
    # to do that.
    
    sub atlevel($tree, $level) {
        return unless defined($tree);
        return $tree[0] if $level == 1;
        gather {
           take atlevel($tree[1], $level - 1);
           take atlevel($tree[2], $level - 1);
        }
    }
    
    my @e1 = 'A', ;
    my @e2 = 'B', 'E';
    my @e3 = 'C', 'D';
    is(atlevel($tree, 1), @e1, "atlevel() works at level 1");
    is(atlevel($tree, 2), @e2, "atlevel() works at level 2");
    is(atlevel($tree, 3), @e3, "atlevel() works at level 3");
}

{
    # P63 (**) Construct a complete binary tree
    # 
    # A complete binary tree with height H is defined as follows: The levels
    # 1,2,3,...,H-1 contain the maximum number of nodes (i.e 2**(i-1) at the
    # level i, note that we start counting the levels from 1 at the root).
    # In level H, which may contain less than the maximum possible number of
    # nodes, all the nodes are "left-adjusted". This means that in a
    # levelorder tree traversal all internal nodes come first, the leaves
    # come second, and empty successors (the nil's which are not really
    # nodes!) come last.
    # 
    # Particularly, complete binary trees are used as data structures (or
    # addressing schemes) for heaps.
    # 
    # We can assign an address number to each node in a complete binary tree
    # by enumerating the nodes in levelorder, starting at the root with
    # number 1. In doing so, we realize that for every node X with
    # address A the following property holds: The address of X's left and
    # right successors are 2*A and 2*A+1, respectively, supposed the
    # successors do exist. This fact can be used to elegantly construct a
    # complete binary tree structure. Write a predicate
    # complete-binary-tree/2 with the following specification:
    # 
    # % complete-binary-tree(N,T) :- T is a complete binary tree with N nodes. (+,?)
    # 
    # Test your predicate in an appropriate way.
    
    skip "Test(s) not yet written: (**) Construct a complete binary tree", 1;
}

sub count($tree) {
    return 0 unless $tree.defined;
    return 1 + count($tree[1]) + count($tree[2]);
}
    
{
    # P64 (**) Layout a binary tree (1)
    # 
    # Given a binary tree as the usual Prolog term t(X,L,R) (or nil). As a
    # preparation for drawing the tree, a layout algorithm is required to determine
    # the position of each node in a rectangular grid. Several layout methods are
    # conceivable, one of them is shown in the illustration below.
    # 
    # In this layout strategy, the position of a node v is obtained by the following
    # two rules:
    # 
    # * x(v) is equal to the position of the node v in the inorder sequence
    # * y(v) is equal to the depth of the node v in the tree
    # 
    # 
    # 
    # In order to store the position of the nodes, we extend the Prolog term
    # representing a node (and its successors) as follows:
    # 
    # % nil represents the empty tree (as usual)
    # % t(W,X,Y,L,R) represents a (non-empty) binary tree with root W "positioned" at (X,Y), and subtrees L and R
    # 
    # Write a predicate layout-binary-tree/2 with the following specification:
    # 
    # % layout-binary-tree(T,PT) :- PT is the "positioned" binary tree obtained from
    # the binary tree T. (+,?)
    # 
    # Test your predicate in an appropriate way.
     
    my $tree = ['n', ['k', ['c', ['a', Any, Any], ['h', ['g', ['e', Any, Any], Any], Any]], ['m', Any, Any]], ['u', ['p', Any, ['s', ['q', Any, Any]], Any], Any]];
      
    my $expected = ['n', 8, 1, 
            ['k', 6, 2, 
                ['c', 2, 3, 
                    ['a', 1, 4,  Any, Any], 
                    ['h', 5, 4,  
                        ['g', 4, 5, 
                            ['e', 3, 6, Any, Any], Any], Any]], 
                ['m', 7, 3, Any, Any]], 
            ['u', 12, 2, 
                ['p', 9, 3, Any, 
                    ['s', 11, 4,
                        ['q', 10, 5, Any, Any]], Any], Any]];
    
    sub align($tree, $prev_x, $prev_y, $lr){
        return Any unless defined($tree);
        my $y = $prev_y + 1;
        my $x = 0;
        if $lr eq "l" {
            $x = $prev_x - 1 - count($tree[2]);
        } else {
            $x = $prev_x + 1 + count($tree[1]);
        }
        return [$tree[0], 
               $x, 
               $y, 
               align($tree[1], $x, $y, "l"),
               align($tree[2], $x, $y, "r")];
    }
    my $result = align($tree, 0, 0, "r");
    
    is($result, $expected, "tree alignment works");
}

{
    # P64 (**) Layout a binary tree (1)
    # 
    # Given a binary tree as the usual Prolog term t(X,L,R) (or nil). As a
    # preparation for drawing the tree, a layout algorithm is required to determine
    # the position of each node in a rectangular grid. Several layout methods are
    # conceivable, one of them is shown in the illustration below.
    # 
    # In this layout strategy, the position of a node v is obtained by the following
    # two rules:
    # 
    # * x(v) is equal to the position of the node v in the inorder sequence
    # * y(v) is equal to the depth of the node v in the tree
    # 
    # 
    # 
    # In order to store the position of the nodes, we extend the Prolog term
    # representing a node (and its successors) as follows:
    # 
    # % nil represents the empty tree (as usual)
    # % t(W,X,Y,L,R) represents a (non-empty) binary tree with root W "positioned" at (X,Y), and subtrees L and R
    # 
    # Write a predicate layout-binary-tree/2 with the following specification:
    # 
    # % layout-binary-tree(T,PT) :- PT is the "positioned" binary tree obtained from
    # the binary tree T. (+,?)
    # 
    # Test your predicate in an appropriate way.
     
    my $tree = ['n', ['k', ['c', ['a', Any, Any], ['h', ['g', ['e', Any, Any], Any], Any]], ['m', Any, Any]], ['u', ['p', Any, ['s', ['q', Any, Any]], Any], Any]];
      
    my $expected = ['n', 8, 1, 
            ['k', 6, 2, 
                ['c', 2, 3, 
                    ['a', 1, 4,  Any, Any], 
                    ['h', 5, 4,  
                        ['g', 4, 5, 
                            ['e', 3, 6, Any, Any], Any], Any]], 
                ['m', 7, 3, Any, Any]], 
            ['u', 12, 2, 
                ['p', 9, 3, Any, 
                    ['s', 11, 4,
                        ['q', 10, 5, Any, Any]], Any], Any]];
    
    sub align2($tree, $prev_x, $prev_y, $lr){
        return Any unless defined($tree);
        my $y = $prev_y + 1;
        my $x = 0;
        if $lr eq "l" {
            $x = $prev_x - 1 - count($tree[2]);
        } else {
            $x = $prev_x + 1 + count($tree[1]);
        }
        return [$tree[0], 
               $x, 
               $y, 
               align2($tree[1], $x, $y, "l"),
               align2($tree[2], $x, $y, "r")];
    }
    my $result = align2($tree, 0, 0, "r");
    
    is($result, $expected, "tree alignment works");
}

{
    # P66 (***) Layout a binary tree (3)
    # 
    # Yet another layout strategy is shown in the illustration opposite. The
    # method yields a very compact layout while maintaining a certaing
    # symmetry in every node. Find out the rules and write the corresponding
    # Prolog predicate. Hint: Consider the horizontal distance between a node
    # and its successor nodes. How tight can you pack together two subtrees
    # to construct the combined binary tree?
    # 
    # Use the same conventions as in problem P64 and P65 and test your
    # predicate in an appropriate way. Note: This is a difficult problem.
    # Don't give up too early!
    # 
    # Which layout do you like most?
    
    skip "Test(s) not yet written: (***) Layout a binary tree (3)", 1;
}

{
    # P67 (**) A string representation of binary trees
    # 
    # 
    # Somebody represents binary trees as strings of the following type
    # (see example opposite):
    # 
    # a(b(d,e),c(,f(g,)))
    # 
    # a) Write a Prolog predicate which generates this string representation,
    # if the tree is given as usual (as nil or t(X,L,R) term). Then write a
    # predicate which does this inverse; i.e. given the string representation,
    # construct the tree in the usual form. Finally, combine the two
    # predicates in a single predicate tree-string/2 which can be used in
    # both directions.
    
    my $tree = ['a', ['b', ['d'], ['e']], ['c', Any, ['f', ['g']]]]; 
    my $expected = "a(b(d,e),c(,f(g,)))";
    
    sub stringify($tree) {
        return '' unless defined($tree);
        return $tree[0] if not defined($tree[1]) and (not defined($tree[2]));
        return $tree[0] ~ '(' ~ stringify($tree[1]) ~ ',' ~ stringify($tree[2]) ~ ')';
    }
    
    is(stringify($tree), $expected, "string representation of binary tree");
    
    # b) Write the same predicate tree-string/2 using difference lists and a single
    # predicate tree-dlist/2 which does the conversion between a tree and a
    # difference list in both directions.
    # 
    # For simplicity, suppose the information in the nodes is a single letter
    # and there are no spaces in the string.
    
    skip "Test(s) not yet written: (**) A string representation of binary trees", 1;
}

{
    # P68 (**) Preorder and inorder sequences of binary trees
    # 
    # We consider binary trees with nodes that are identified by single lower-case
    # letters, as in the example of problem P67.
    # 
    # a) Write predicates preorder/2 and inorder/2 that construct the preorder and
    # inorder sequence of a given binary tree, respectively. The results should be
    # atoms, e.g. 'abdecfg' for the preorder sequence of the example in problem P67.
    # 
    # b) Can you use preorder/2 from problem part a) in the reverse direction; i.e.
    # given a preorder sequence, construct a corresponding tree? If not, make the
    # necessary arrangements.
    # 
    # c) If both the preorder sequence and the inorder sequence of the nodes of a
    # binary tree are given, then the tree is determined unambiguously. Write a
    # predicate pre-in-tree/3 that does the job.
    # 
    # d) Solve problems a) to c) using difference lists. Cool! Use the predefined
    # predicate time/1 to compare the solutions.
    # 
    # What happens if the same character appears in more than one node. Try for
    # instance pre-in-tree(aba,baa,T).
    
    skip "Test(s) not yet written: (**) Preorder and inorder sequences of binary trees", 1;
}

{
    # P69 (**) Dotstring representation of binary trees
    # 
    # We consider again binary trees with nodes that are identified by single
    # lower-case letters, as in the example of problem P67. Such a tree can be
    # represented by the preorder sequence of its nodes in which dots (.) are
    # inserted where an empty subtree (nil) is encountered during the tree
    # traversal. For example, the tree shown in problem P67 is represented as
    # 'abd..e..c.fg...'. First, try to establish a syntax (BNF or syntax diagrams)
    # and then write a predicate tree-dotstring/2 which does the conversion in both
    # directions. Use difference lists.
    # 
    # Multiway Trees
    # 
    # A multiway tree is composed of a root element and a (possibly empty) set of
    # successors which are multiway trees themselves. A multiway tree is never
    # empty. The set of successor trees is sometimes called a forest.
    # 
    # 
    # In Prolog we represent a multiway tree by a term t(X,F), where X denotes the
    # root node and F denotes the forest of successor trees (a Prolog list). The
    # example tree depicted opposite is therefore represented by the following
    # Prolog term:
    # 
    # T = t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])
    
    skip "Test(s) not yet written: (**) Dotstring representation of binary trees", 1;
}

{
    # P70 (**) Tree construction from a node string
    # 
    # We suppose that the nodes of a multiway tree contain single characters. In the
    # depth-first order sequence of its nodes, a special character ^ has been
    # inserted whenever, during the tree traversal, the move is a backtrack to the
    # previous level.
    # 
    # By this rule, the tree in the figure opposite is represented as: afg^^c^bd^e^^^
    # 
    # Define the syntax of the string and write a predicate tree(String,Tree) to
    # construct the Tree when the String is given. Work with atoms (instead of
    # strings). Make your predicate work in both directions.
    
    skip "Test(s) not yet written: (**) Tree construction from a node string", 1;
}

# vim: ft=perl6

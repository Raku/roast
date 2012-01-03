use v6;
use Test;
plan 37;

{
    # P54A (*) Check whether a given term represents a binary tree
    # 
    # Write a predicate istree which returns true if and only if its argument is a
    # list representing a binary tree.
    # 
    # Example:
    # * (istree (a (b nil nil) nil))
    # T
    # * (istree (a (b nil nil)))
    # NIL
    
    # We keep representing trees as lists
    # but it could be interesting to use something like
    #  subtype List::Tree of List where {istree($_)}
    # or to define a proper class Node
    
    sub istree($obj) returns Bool {
      return Bool::True unless $obj.defined;
      return +$obj==3 and istree($obj[1]) and istree($obj[2]);
    }
        
    ok istree(Any), "We tell that an empty tree is a tree";
    ok istree(['a',Any,Any]), ".. and a one-level tree is a tree";
    ok istree(['a',Any,['c',Any,Any]]), ".. and n-level trees";
    ok !istree([]), ".. and fail with empty lists";
    ok !istree(<a b>),".. or other malformed trees";
}

{
    # P55 (**) Construct completely balanced binary trees
    # 
    # In a completely balanced binary tree, the following property holds for
    # every node: The number of nodes in its left subtree and the number of
    # nodes in its right subtree are almost equal, which means their
    # difference is not greater
    # than one.
    # 
    # Write a function cbal-tree to construct completely balanced binary
    # trees for a given number of nodes. The predicate should generate all
    # solutions via
    # backtracking. Put the letter 'x' as information into all nodes of the
    # tree.
    # 
    # Example:
    # * cbal-tree(4,T).
    # T = t(x, t(x, nil, nil), t(x, nil, t(x, nil, nil))) ;
    # T = t(x, t(x, nil, nil), t(x, t(x, nil, nil), nil)) ;
    # etc......No

    sub cbal-tree(Int $n) {
        return Any if $n == 0;
        gather {
            if $n % 2 == 1 {
                my $k = ($n - 1) div 2;
                for cbal-tree($k) -> $a {
                    for cbal-tree($k) -> $b {
                        take ['x', $a, $b];
                    }
                }
            } else {
                my $k = $n div 2;
                for cbal-tree($k) -> $a {
                    for cbal-tree($k - 1) -> $b {
                        take ['x', $a, $b];
                    }
                }
                for cbal-tree($k - 1) -> $a {
                    for cbal-tree($k) -> $b {
                        take ['x', $a, $b];
                    }
                }
            }
        }
    }

    is cbal-tree(1),
       (['x', Any, Any],),
       'built a balanced binary tree with 1 item';

    is cbal-tree(2), 
       (['x', ['x', Any, Any], Any],
        ['x', Any,               ['x', Any, Any]],),
       'built a balanced binary tree with 2 items';

    is cbal-tree(3),
       (['x', ['x', Any, Any], ['x', Any, Any]],),
       'built a balanced binary tree with 3 items';

    is +cbal-tree(4), 4, 'built the right number of balanced trees with 4 items';
}

{
    # P56 (**) Symmetric binary trees
    # 
    # Let us call a binary tree symmetric if you can draw a vertical line
    # through the root node and then the right subtree is the mirror image
    # of the left subtree.
    # Write a predicate symmetric/1 to check whether a given binary tree is
    # symmetric. Hint: Write a predicate mirror/2 first to check whether one
    # tree is
    # the mirror image of another. We are only interested in the structure,
    # not in
    # the contents of the nodes.
    
    sub symmetric($tree) {
        mirror(left($tree),right($tree))
    }
    
     
    # We use multi subs so that in theory we can replace this definitions 
    # for example using classes or Array subtyping instead of lispish trees
    
    # in Rakudo you can't pass a Mu to where an Array is expected,
    # so we add multis for explicit undefined values
    multi sub mirror(Mu:U $a, Mu:U $b) { return True;  }   #OK not used
    multi sub mirror(Mu:U $a, @b)      { return False; }   #OK not used
    multi sub mirror(@a,      Mu:U $b) { return False; }   #OK not used

    multi sub mirror(@first, @second) {
        if (@first|@second == (Mu,)) {
            return @first == @second ;
        }
        mirror(left(@first),right(@second)) and mirror(right(@first),left(@second))
    }

    multi sub left(@tree) {
        @tree[1]
    }
    multi sub right(@tree) {
        @tree[2]
    }

    is left(('a',1,2)), 1, "left()  works";
    is right(('b',1,2)), 2, "right() works";

    ok mirror(Mu,Mu),"mirror works with empty trees";
    ok !mirror(Mu,[]),"mirror spots differences";
    ok mirror((1,Mu,Mu),(2,Mu,Mu)),"mirror can recurse";
    ok !mirror((1,Mu,[]),(2,Mu,Mu)),"mirror spots differences recurring";

    ok symmetric([1,Mu,Mu]), "symmetric works with 1-level trees";
    ok !symmetric([1,Mu,[2,Mu,Mu]]),"symmetric find asymettric trees";
    ok symmetric([1,
            [11,
            [111,Mu,Mu],
            [112,[1121,Mu,Mu],Mu]],
            [12,
            [121,Mu,[1221,Mu,Mu]],
            [122,Mu,Mu]]]),
       "symmetric works with n-level trees"; 
}

{
    # P57 (**) Binary search trees (dictionaries)
    # 
    # Use the predicate add/3, developed in chapter 4 of the course, to write a
    # predicate to construct a binary search tree from a list of integer numbers.
    # 
    # Example:
    # * construct([3,2,5,7,1],T).
    # T = t(3, t(2, t(1, nil, nil), nil), t(5, nil, t(7, nil, nil)))
    # 
    # Then use this predicate to test the solution of the problem P56.
    # Example:
    # * test-symmetric([5,3,18,1,4,12,21]).
    # Yes
    # * test-symmetric([3,2,5,7,1]).
    # No

    sub add-to-tree($tree, $node) {
        if $tree ~~ Mu {
            return [$node, Mu, Mu] 
        } elsif $node <= $tree[0] {
            return [$tree[0], add-to-tree($tree[1], $node), $tree[2]];
        } else {
            return [$tree[0], $tree[1], add-to-tree($tree[2], $node)];
        }
    }
    sub construct(*@nodes) {
        my $tree;
        for @nodes {
            $tree = add-to-tree($tree, $_);
        }
        return $tree;
    }

    #?niecza todo
    is construct(3, 2, 5, 7, 1), 
       [3, [2, [1, Mu, Mu], Mu], [5, Mu, [7, Mu, Mu]]],
       'Can construct a binary search tree';
}

{
    # P58 (**) Generate-and-test paradigm
    # 
    # Apply the generate-and-test paradigm to construct all symmetric, completely
    # balanced binary trees with a given number of nodes. Example:
    # 
    # * sym-cbal-trees(5,Ts).
    # 
    # Ts = [t(x, t(x, nil, t(x, nil, nil)), t(x, t(x, nil, nil), nil)), t(x, t(x, t(x, nil, nil), nil), t(x, nil, t(x, nil, nil)))]
    # 
    # How many such trees are there with 57 nodes? Investigate about how many
    # solutions there are for a given number of nodes? What if the number is even?
    # Write an appropriate predicate.

    skip "Test(s) not yet written: (**) Generate-and-test paradigm", 1;
}

{
    # P59 (**) Construct height-balanced binary trees
    # 
    # In a height-balanced binary tree, the following property holds for every
    # node: The height of its left subtree and the height of its right subtree
    # are almost equal, which means their difference is not greater than one.
    # 
    # Write a predicate hbal-tree/2 to construct height-balanced binary trees
    # for a given height. The predicate should generate all solutions via
    # backtracking. Put the letter 'x' as information into all nodes of the
    # tree.
    # 
    # Example:
    # * hbal-tree(3,T).
    # T = t(x, t(x, t(x, nil, nil), t(x, nil, nil)), t(x, t(x, nil, nil), t(x, nil, nil))) ;
    # T = t(x, t(x, t(x, nil, nil), t(x, nil, nil)), t(x, t(x, nil, nil), nil)) ;
    # etc......No

    sub heights(Mu $x) {
        return 0 unless $x.defined;
        gather {
            for heights($x[1]) { take 1 + $_ };
            for heights($x[2]) { take 1 + $_ };
        }
    }

    sub is-hbal($x) {
        my @heights = heights($x).sort;
        return @heights[*-1] - @heights[0] <= 1;
    }

    sub hbal-tree(Int $n) {
        return Mu if $n == 0;
        return ['x', Mu, Mu] if $n == 1;
        gather {
            for hbal-tree($n - 1) -> $a {
                for hbal-tree($n - 1) -> $b {
                    take ['x', $a, $b];
                }
                for hbal-tree($n - 2) -> $b {
                    if is-hbal(['x', $a, $b]) {
                        take ['x', $a, $b];
                        take ['x', $b, $a];
                    }
                }
            }
        }
    };

    # XXX somebody please check if 15 is really the expected number
    my @results = hbal-tree(3);
    is +@results, 15, 'Found 15 height balanced trees of height 3';
    for ^15  {
        ok is-hbal(@results[$_]), "tree {$_+1} is really balanced";

    }
}

{
    # P60 (**) Construct height-balanced binary trees with a given number
    # of nodes
    # 
    # Consider a height-balanced binary tree of height H. What is the maximum
    # number of nodes it can contain?  Clearly, MaxN = 2**H - 1. However, 
    # what is the minimum number MinN? This question is more difficult. 
    # Try to find a recursive
    # statement and turn it into a predicate minNodes/2 defined as follwos:
    # 
    # % minNodes(H,N) :- N is the minimum number of nodes in a 
    # height-balanced binary tree of height H.
    # 
    # (integer,integer), (+,?)
    # 
    # On the other hand, we might ask: what is the maximum height H a
    # height-balanced  binary tree with N nodes can have?
    # 
    # % maxHeight(N,H) :- H is the maximum height of a height-balanced
    # binary tree with N nodes
    # (integer,integer), (+,?)
    # 
    # Now, we can attack the main problem: construct all the height-balanced
    # binary trees with a given nuber of nodes.
    # 
    # % hbal-tree-nodes(N,T) :- T is a height-balanced binary tree with N nodes.
    # 
    # Find out how many height-balanced trees exist for N = 15.

    skip "Test(s) not yet written: (**) Construct height-balanced binary trees with a given number of nodes", 1;
}

# vim: ft=perl6

use v6;
use Test;
plan 11;

{
    # P41 (**) A list of Goldbach compositions.
    #
    # Given a range of integers by its lower and upper limit, print a list
    # of all even numbers and their Goldbach composition.
    #
    # Example:
    # * (goldbach-list 9 20)
    # 10 = 3 + 7
    # 12 = 5 + 7
    # 14 = 3 + 11
    # 16 = 3 + 13
    # 18 = 5 + 13
    # 20 = 3 + 17
    #
    # In most cases, if an even number is written as the sum of two prime 
    # numbers, one of them is very small. Very rarely, the primes are both 
    # bigger than say 50. Try to find out how many such cases there are in
    # the range 2..3000.
    #
    # Example (for a print limit of 50):
    # * (goldbach-list 1 2000 50)
    # 992 = 73 + 919
    # 1382 = 61 + 1321
    # 1856 = 67 + 1789
    # 1928 = 61 + 1867
    
    sub primes($from, $to) {
        my @p = (2);
        for 3..$to -> $x {
            push @p, $x unless grep { $x % $_ == 0 }, 2..ceiling sqrt $x;
        }
        grep { $_ >= $from }, @p;
    }
    
    sub goldbach($n) {
        my @p = primes(1, $n-1);
        for @p -> $x {
            for @p -> $y {
                return ($x,$y) if $x+$y == $n;
            }
        }
    }
    
    sub goldbachs($from, $to) {
        [ map { [$_, goldbach $_] }, grep { $_ % 2 == 0 }, $from .. $to ]
    }
    
    is goldbachs(3, 11), [[4, 2, 2], [6, 3, 3], [8, 3, 5], [10, 3, 7]], "yep.";
}

#?rakudo skip 's:P5///'
{
    # P46 (**) Truth tables for logical expressions.
    #
    # Define predicates and/2, or/2, nand/2, nor/2, xor/2, impl/2 and equ/2 (for
    # logical equivalence) which succeed or fail according to the result of their
    # respective operations; e.g. and(A,B) will succeed, if and only if both A and B
    # succeed. Note that A and B can be Prolog goals (not only the constants true and
    # fail).
    #
    # A logical expression in two variables can then be written in prefix notation,
    # as in the following example: and(or(A,B),nand(A,B)).
    #
    # Now, write a predicate table/3 which prints the truth table of a given logical
    # expression in two variables.
    #
    # Example:
    # * table(A,B,and(A,or(A,B))).
    # true true true
    # true fail true
    # fail true fail
    # fail fail fail
    
    
    # --
    
    
    sub stringify($Thing) {
        if $Thing {
            return 'true';
        } else {
            return 'fail'; # as per problem description
        };
    };
    
    # Obviously we can't just make 'or' respective 'and' subs
    # because those are builtin operators.  Maybe there's a way
    # around that, but I wouldn't know how to call the original
    # operator in the sub (core::and?), so I bend the task
    # description a little and just prefix the subs with
    # an underscore.
    sub _or($A, $B) {return ($A or $B)};
    sub _and($A, $B) {return ($A and $B)};
    sub _nand($A, $B) {return !($A and $B)};
    sub _nor($A, $B) {return !($A or $B)};
    sub _xor($A, $B) { # FIXME if you know DeMorgan
        return False if $A and $B;
        return ($A or $B);
    };
    sub _impl($A, $B) {
        if $A and !$B {
            return False;
        } else {
            return True;
        };
    };
    sub _equ($A, $B) {return $A == $B};
    
    sub table($expr is copy) {
    # I have to copy this around or else I get
    # "Can't modify constant item: VStr"
    # error as soon as I want to modify it
    
        $expr ~~ s:P5/^A,B,//;
        $expr ~~ s:P5:g/([AB])/$$0/;
    # first capture is now $0
        $expr ~~ s:P5:g/([nx]?or|n?and|impl|equ)/_$0/;     #:
    
        my @table;
        for (True, False) -> $A {
            for (True, False) -> $B {
                push @table, (
                    join ' ', (
                        stringify $A,
                        stringify $B,
                        stringify eval $expr
                    )
                ) ~ "\n";
            };
        };
    
        return @table;
    };
    
    is q[true true true
true fail true
fail true fail
fail fail fail
]
    , join('',
        table('A,B,and(A,or(A,B))')
    ), 'P46 (**) Truth tables for logical expressions.';
}

{
    # P47 (*) Truth tables for logical expressions (2).
    # 
    # Continue problem P46 by defining and/2, or/2, etc as being operators. This
    # allows to write the logical expression in the more natural way, as in the
    # example: A and (A or not B). Define operator precedence as usual; i.e.
    # as in  Java.
    # 
    # Example:
    # * table(A,B, A and (A or not B)).
    # true true true
    # true fail true
    # fail true fail
    # fail fail fail

    skip "Test(s) not yet written: (*) Truth tables for logical expressions (2).", 1;
}

{
    # P48 (**) Truth tables for logical expressions (3).
    # 
    # Generalize problem P47 in such a way that the logical expression may contain
    # any number of logical variables. Define table/2 in a way that table(List,Expr)
    # prints the truth table for the expression Expr, which contains the logical
    # variables enumerated in List.
    # 
    # Example:
    # * table([A,B,C], A and (B or C) equ A and B or A and C).
    # true true true true
    # true true fail true
    # true fail true true
    # true fail fail true
    # fail true true true
    # fail true fail true
    # fail fail true true
    # fail fail fail true
    
    skip "Test(s) not yet written: (**) Truth tables for logical expressions (3).", 1;

}

{
    # P49 (**) Gray code.
    # 
    # An n-bit Gray code is a sequence of n-bit strings constructed according to
    # certain rules. For example,
    # 
    # n = 1: C(1) = ['0','1'].
    # n = 2: C(2) = ['00','01','11','10'].
    # n = 3: C(3) = ['000','001','011','010',Â´110Â´,Â´111Â´,Â´101Â´,Â´100Â´].
    # 
    # Find out the construction rules and write a predicate with the following
    # specification:
    # 
    # % gray(N,C) :- C is the N-bit Gray code
    # 
    # Can you apply the method of "result caching" in order to make the predicate
    # more efficient, when it is to be used repeatedly?

    # TODO: add an 'is cached' trait once that's implemented
    sub gray($n) {
        return ('',) if $n == 0;
        '0' xx 2**($n-1) >>~<< gray($n-1), 
            '1' xx 2 ** ($n-1) >>~<< gray($n-1).reverse;
    }
    is gray(1), <0 1>;
    is gray(2), <00 01 11 10>;
    is gray(3), <000 001 011 010 110 111 101 100>;
}

#?rakudo skip 'Shaped variable declarations'
{    
    sub gray2($n) {
        return ('',) if $n == 0;
        state @g[$n] //= ('0' >>~<< gray2($n-1), '1' >>~<< gray2($n-1).reverse);
    }
    is gray2(1), <0 1>, 'gray code for n = 1';
    is gray2(2), <00 01 11 10>, 'gray code for n = 2';
    is gray2(3), <000 001 011 010 110 111 101 100>, 'gry code for n = 3';
}

{
    # P50 (***) Huffman code.
    # 
    # First of all, consult a good book on discrete mathematics or algorithms
    # for a  detailed description of Huffman codes!
    # 
    # We suppose a set of symbols with their frequencies, given as a list of 
    # fr(S,F) terms. 
    # Example: [fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)]. 
    # 
    # Our objective is to construct a list hc(S,C) terms, where C is the
    # Huffman code word for the symbol S. In our example, the result could
    # be Hs = [hc(a,'0'), # hc(b,'101'), hc(c,'100'), hc(d,'111'), 
    # hc(e,'1101'), hc(f,'1100')] [hc(a,'01'),...etc.]. The task shall be
    # performed by the predicate huffman/2
    # defined as follows:
    # 
    # % huffman(Fs,Hs) :- Hs is the Huffman code table for the frequency table Fs
    # 
    # Binary Trees
    # 
    # A binary tree is either empty or it is composed of a root element and two
    # successors, which are binary trees themselves.  In Lisp we represent the empty
    # tree by 'nil' and the non-empty tree by the list (X L R), where X denotes the
    # root node and L and R denote the left and right subtree, respectively. The
    # example tree depicted opposite is therefore represented by the following list:
    # 
    # (a (b (d nil nil) (e nil nil)) (c nil (f (g nil nil) nil)))
    # 
    # Other examples are a binary tree that consists of a root node only:
    # 
    # (a nil nil) or an empty binary tree: nil.
    # 
    # You can check your predicates using these example trees. They are given as test
    # cases in p54.lisp.
    
    my @fr = (
            ['a', 45],
            ['b', 13],
            ['c', 12],
            ['d', 16],
            ['e', 9 ],
            ['f', 5 ],
    	 );
    
    my %expected = (
            'a' => '0',
            'b' => '101',
            'c' => '100',
            'd' => '111',
            'e' => '1101',
            'f' => '1100'
            );
    
    my @c = @fr;
    
    # build the tree:
    while @c.elems > 1 {
        # Choose lowest frequency nodes and combine.  Break ties
        # to create the tree the same way each time.
        @c = sort { $^a[1] <=> $^b[1] || $^a[0] cmp $^b[0] }, @c;
        my $a = shift @c;
        my $b = shift @c;
        unshift @c, [[$a[0], $b[0]], $a[1] + $b[1]];
    }
    
    my %res;
    
    sub traverse ($a, Str $code = "") {
        if $a ~~ Str {
            %res{$a} = $code;
        } else {
            traverse($a[0], $code ~ '0');
            traverse($a[1], $code ~ '1');
        }
    }
    traverse(@c[0][0]);
    
    is(~%res.sort, ~%expected.sort, "Huffman tree builds correctly");
    
        
}

# vim: ft=perl6

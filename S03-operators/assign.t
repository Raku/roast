use v6;
use Test;

#                      +---- UTF8 non-breaking space here!
#                      |
#                      V
# L<S03/Changes to Perl 5 operators/list assignment operator now parses on the right>

plan 309;


# tests various assignment styles
{
    my ($foo, $bar) = ("FOO", "BAR");
    is($foo, "FOO", "assigned correct value to first of two scalars");
    is($bar, "BAR", "... and second");

    ($foo, $bar) = ($bar, $foo);
    is($foo, "BAR", "swap assignment works for the first value");
    is($bar, "FOO", "... and second");
}

#?rakudo skip "sub form of operators missing"
{
    my $x = 1;
    &infix:<=>.($x, 0);
    is($x, 0, 'assignment operator called as function');
}

#?rakudo skip "sub form of operators missing"
{
    my $x = 1;
    infix:<=>($x, 0);
    is($x, 0, 'assignment operator called as function');
}

{
    # swap two elements in the same array 
    # (moved this from array.t)
    my @a = 1 .. 5;
    @a[0,1] = @a[1,0];
    is(@a[0], 2, "slice assignment swapping two element in the same array");
    is(@a[1], 1, "slice assignment swapping two element in the same array");
}

{
    # swap two elements as slice, dwim slice from @b subscript
    
    my @a = 1 .. 2;
    my @b = 0 .. 2;
    @a[@b] = @a[1, 0], 3;
    is(@a[0], 2, "slice assignment swapping with array dwim");
    is(@a[1], 1, "slice assignment swapping with array dwim");
    is(@a[2], 3, "slice assignment swapping with array dwim makes listop");
}

{
    # list assignments

    my @a = 1 .. 3;
    my ($one, $two, $three) = @a;
    is($one, 1, 'list assignment my ($, $, $) = @ works');
    is($two, 2, 'list assignment my ($, $, $) = @ works');
    is($three, 3, 'list assignment my ($, $, $) = @ works');

}


#?pugs skip 'skipping assignment with skipped values via $'
#?rakudo skip 'skip items in list assignment with bare $ '
{
    # testing list assignments with skipped values
     my ($one, $, $three) = 1..3;
     is("$one $three", "1 3", 'list assignment my ($a, $, $b) = @ works');

     my ($, $two) = 1..2;
     is($two, 2, 'list assignment my ($, $a) = @ works');
     my ($, $, $, $four) = 1..4;
     is($four, 4, 'list assignment my ($, $, $, $a) = @ works');

     my ($, @b, $c) = 1..4;
     is(~@b, "2 3 4", 'list assignment my ($, @) = @ works');
     ok(!defined($c), 'list assignment my ($, @, $c) = @ works');
}

#?pugs skip "skipping assignment with skipped values via * in signature"
#?rakudo skip 'skip items in list assignment with bare $ '
{
    # testing list assignments with skipped values
     my ($one, $, $three) = 1..3;
     is("$one $three", "1 3", 'list assignment my ($a, $, $b) = @ works');

     my ($, $two) = 1..2;
     is($two, 2, 'list assignment my ($, $a) = @ works');
     my ($, $, $, $four) = 1..4;
     is($four, 4, 'list assignment my ($, $, $, $a) = @ works');

     my ($, @b, $c) = 1..4;
     is(~@b, "2 3 4", 'list assignment my ($, @) = @ works');
     ok(!defined($c), 'list assignment my ($, @, $c) = @ works');
}

#?pugs skip "skipping assignment with skipped values via * in lvalue"
{
    # testing list assignments with skipped values
     my ($one, $two, $three, $four);
     ($one, *, $three) = 1..3;
     is("$one $three", "1 3", 'list assignment ($a, *, $b) = @ works');

     (*, $two, *) = 1..3;
     is($two, 2, 'list assignment (*, $a, *) = @ works');
     (*, *, *, $four) = 1..4;
     is($four, 4, 'list assignment (*, *, *, $a) = @ works');

     my (@b, $c);
     (*, @b, $c) = 1..4;
     is(~@b, "2 3 4", 'list assignment (*, @) = @ works');
     ok(!defined($c), 'list assignment (*, @, $c) = @ works');
}

{
   # testing list assignment syntax

    my ($a,$b,$c,@a);
    ($a,$b,$c) = 1 .. 3;
    @a = 1 .. 3;
    my ($s,@b) = 1 .. 3;

    is($a,1,"'\$a' is '1'?: (\$,\$,\$) = 1 .. 3");
    is($b,2,"'\$b' is '2'?: (\$,\$,\$) = 1 .. 3");
    is($c,3,"'\$c' is '3'?: (\$,\$,\$) = 1 .. 3"); 
    is(@a,'1 2 3',"'{\@a}' is '1 2 3'?:       \@a = 1 .. 3");
    is($s,'1',  "\$s is '1'?:       my (\$s,\@a) = 1 .. 3");
    #?rakudo todo 'arrays on LHS of list assignment'
    is(@b,'2 3',"'{\@b}' is '2 3'?: my (\$s,\@a) = 1 .. 3"); 
}

{
    my @a;
    @a[1, 2, 3] = 100, 200, 300;
    is(@a[1], 100, "assigned correct value from list to sliced array");
    is(@a[2], 200, "... and second");
    is(@a[3], 300, "... and third");
    ok(!defined(@a[0]), "won't modify unassigned one");

    my @b;
    (@b[2, 1, 0]) = 401, 201, 1;
    is(@b[0], 1, "assigned correct value from list to unsorted sliced array");
    is(@b[1], 201, "... and second");
    is(@b[2], 401, "... and third");
}

#?rakudo skip "ResizablePMCArray: Can't shift from an empty array!"
{ 
    my @c;
    my @d;
    (@c[1, 2], @c[3], @d) = 100, 200, 300, 400, 500;
    is(@c[1], 100, "assigned correct value from list to slice-in-list");
    is(@c[2], 200, "... and second");
#?pugs 3 todo 'feature'
    is(@c[3], 300, "... and third");
    is(@d[0], 400, "... and fourth");
    is(@d[1], 500, "... and fifth");
    ok(!defined(@c[0]), "won't modify unassigned one");

}

{
    # chained @array = %hash = list assignment 
    my (@a, @b, %h);
    @a = %h = 1,2;
    @b = %h;
    is(@a[0], @b[0], 'chained @ = % = list assignment');
    is(@a[1], @b[1], 'chained @ = % = list assignment');
}

{
    # chained $scalar = %hash = list assignment 
    my ($s, $t, %h);
    $s = %h = 1,2;
    $t = %h;
    is($s, $t, 'chained $ = % = list assignment');
}

#?rakudo skip 'arrays on LHS of list assignment'
{
    # (@b, @a) = (@a, @b) assignment
    my (@a, @b);
    @a = 1;
    @b = 2;
    (@b, @a) = (@a, @b);
    ok(!defined(@a[0]), '(@b, @a) = (@a, @b) assignment \@a[0] == undef');
    is(@b[0], 1,     '(@b, @a) = (@a, @b) assignment \@b[0]');
    is(@b[1], 2,     '(@b, @a) = (@a, @b) assignment \@b[1]');
}

#?rakudo skip "unknown reasons"
{
    # (@b, @a) = @a, @b assignment
    my (@a, @b);
    @a = (1);
    @b = (2);
    (@b, @a) = @a, @b;
    ok(!defined(@a[0]), '(@b, @a) = @a, @b assignment \@a[0] == undef');
    is(@b[0], 1,     '(@b, @a) = @a, @b assignment \@b[0]');
    is(@b[1], 2,     '(@b, @a) = @a, @b assignment \@b[1]');
}

my @p;

#?rakudo skip "unknown reasons"
{
    my $a;
    @p = $a ||= 3, 4;
    is($a,3, "||= operator");
    is(@p[0],3, "||= operator parses as item assignment 1");
    is(@p[1],4, "||= operator parses as item assignment 2");
    @p = $a ||= 10, 11;
    is($a,3, "... and second");
    is(@p[0],3, "||= operator parses as item assignment 3");
    is(@p[1],11, "||= operator parses as item assignment 4");
}

#?rakudo skip "unknown reasons"
{
    my $a;
    @p = $a //= 3, 4;
    is($a, 3, "//= operator");
    is(@p[0],3, "||= operator parses as item assignment 1");
    is(@p[1],4, "||= operator parses as item assignment 2");
    @p = $a //= 10, 11;
    is($a, 3, "... and second");
    is(@p[0],3, "||= operator parses as item assignment 3");
    is(@p[1],11, "||= operator parses as item assignment 4");
    my %hash;
    %hash<foo> //= hash();
    is(WHAT %hash<foo>, 'Hash', "Verify //= autovivifies correctly");
    %hash<bar> //= [];
    is(WHAT %hash<foo>, 'Array', "Verify //= autovivifies correctly");
}

#?rakudo skip "unknown reasons"
{
    my $a = 3;
    @p = $a &&= 42, 43;
    is($a, 42, "&&= operator");
    is(@p[0],42, "&&= operator parses as item assignment 1");
    is(@p[1],43, "&&= operator parses as item assignment 2");
    $a = 0;
    @p = $a &&= 10, 11;
    is($a, 0, "... and second");
    is(@p[0],0, "&&= operator parses as item assignment 3");
    is(@p[1],11, "&&= operator parses as item assignment 4");
}

{
    my $c; 
    (($c = 3) = 4); 
    is($c, 4, '(($c = 3) = 4) return val should be good as an lval');
}

{
    my $x = 42;
    @p = $x += 6, 7;
    is($x, 48, '+= operator');
    is(@p[0],48, "+= operator parses as item assignment 1");
    #?rakudo todo "item assignment parsing"
    is(@p[1],47, "+= operator parses as item assignment 2");
}

{
    my $x = 42;
    @p = $x -= 6, 7;
    is($x, 36, '-= operator');
    is(@p[0],36, "-= operator parses as item assignment 1");
    is(@p[1],7, "-= operator parses as item assignment 2");
}

{
    my $x = 4;
    @p = $x *= 3, 2;
    is($x, 12, '*= operator');
    is(@p[0],12, "*= operator parses as item assignment 1");
    #?rakudo todo "unknown reasons"
    is(@p[1],12, "*= operator parses as item assignment 2");
}

{
    my $x = 6;
    @p = $x /= 3, 4;
    is($x, 2, '/= operator');
    is(@p[0],2, "/= operator parses as item assignment 1");
    is(@p[1],4, "/= operator parses as item assignment 2");
}

{
    my $x = 2;
    @p = $x **= 3, 4;
    is($x, 8, '**= operator');
    is(@p[0],8, "**= operator parses as item assignment 1");
    is(@p[1],4, "**= operator parses as item assignment 2");
}

{
    my $x = "abc";
    @p = $x ~= "yz", "plugh";
    is($x, 'abcyz', '~= operator');
    is(@p[0],'abcyz', "~= operator parses as item assignment 1");
    is(@p[1],'plugh', "~= operator parses as item assignment 2");
}

{
    my $x = "abc";
    @p = $x x= 3, 4;
    is($x, 'abcabcabc', 'x= operator');
    is(@p[0],'abcabcabc', "x= operator parses as item assignment 1");
    is(@p[1],4, "x= operator parses as item assignment 2");
}

{
    my @x = ( 'a', 'z' );
    @p = @x xx= 3, 4;
    is(+@x,   6,   'xx= operator elems');
    is(@x[0], 'a', 'xx= operator 0');
    is(@x[1], 'z', 'xx= operator 1');
    is(@x[2], 'a', 'xx= operator 2');
    is(@x[3], 'z', 'xx= operator 3');
    is(@x[4], 'a', 'xx= operator 4');
    is(@x[5], 'z', 'xx= operator 5');
    ok(!defined(@x[6]), 'xx= operator 6');
    #?rakudo todo 'LHS of @p = @x xx= 3, 4'
    is(~@p,~(@x,4), "xx= operator parses as item assignment 1");
}

{
    my $x = 1;
    @p = $x +&= 2, 3;
    is($x, 0, '+&= operator');
    is(@p[0],0, "+&= operator parses as item assignment 1");
    is(@p[1],3, "+&= operator parses as item assignment 2");
}

{
    my $x = 1;
    @p = $x +|= 2, 123;
    is($x, 3, '+|= operator');
    is(@p[0],3, "+|= operator parses as item assignment 1");
    is(@p[1],123, "+|= operator parses as item assignment 2");
}

{
    my $x = "z";
    @p = $x ~&= "I", "J";
    is($x, 'H', '~&= operator');
    is(@p[0],'H', "~&= operator parses as item assignment 1");
    is(@p[1],'J', "~&= operator parses as item assignment 2");
}

{
    my $x = "z";
    @p = $x ~|= "I", "J";
    is($x, '{', '~|= operator');
    is(@p[0],'{', "~|= operator parses as item assignment 1");
    is(@p[1],'J', "~|= operator parses as item assignment 2");
}

{
    my $x = 4;
    @p = $x %= 3, 4;
    is($x, 1, '%= operator');
    is(@p[0],1, "%= operator parses as item assignment 1");
    is(@p[1],4, "%= operator parses as item assignment 2");
}

{
    my $x = 1;
    @p = $x +^= 3, 4;
    is($x, 2, '+^= operator');
    is(@p[0],2, "+^= operator parses as item assignment 1");
    is(@p[1],4, "+^= operator parses as item assignment 2");
}

{
    my $x = "z";
    @p = $x ~^= "C", "D";
    is($x, 9, '~^= operator');
    is(@p[0],9, "~^= operator parses as item assignment 1");
    is(@p[1],'D', "~^= operator parses as item assignment 2");
}

#?rakudo skip "unknown reasons"
{
    my $x = 0;
    @p = $x ^^= 42, 43;
    is($x, 42, '^^= operator');
    is(@p[0],42, "^^= operator parses as item assignment 1");
    is(@p[1],43, "^^= operator parses as item assignment 2");
}

{
    my $x = 42;
    @p = $x ?|= 24, 25;
    is($x, 1, '?|= operator');
    is(@p[0],1, "?|= operator parses as item assignment 1");
    is(@p[1],25, "?|= operator parses as item assignment 2");
}

#?pugs eval 'parsefail'
{
    my $x = 42;
    @p = $x ?&= 24, 25;
    is($x, 1, '?&= operator');
    is(@p[0],1, "?&= operator parses as item assignment 1");
    is(@p[1],25, "?&= operator parses as item assignment 2");
}

#?pugs eval 'parsefail'
{
    my $x = 0;
    @p = $x ?^= 42, 43;
    is($x, 1, '?^= operator');
    is(@p[0],1, "?^= operator parses as item assignment 1");
    is(@p[1],43, "?^= operator parses as item assignment 2");
}

#?pugs eval 'parsefail'
{
    my $x = 1;
    @p = $x +<= 8, 9;
    is($x, 256, '+<= operator');
    is(@p[0],256, "+<= operator parses as item assignment 1");
    is(@p[1],9, "+<= operator parses as item assignment 2");
}

#?pugs eval 'parsefail'
{
    my $x = 511;
    @p = $x +>= 8, 9;
    is($x, 1, '+>= operator');
    is(@p[0],1, "+>= operator parses as item assignment 1");
    is(@p[1],9, "+>= operator parses as item assignment 2");
}

# XXX: The following tests assume autoconvertion between "a" and buf8 type
#?pugs eval 'parsefail'
#?rakudo skip "unknown reasons"
{
    my $x = "a";
    @p = $x ~<= 8, 9;
    is($x, "a\0", '~<= operator');
    is(@p[0],"a\0", "~<= operator parses as item assignment 1");
    is(@p[1],9, "~<= operator parses as item assignment 2");
}

#?pugs eval 'parsefail'
#?rakudo skip "unknown reasons"
{
    my $x = "aa";
    @p = $x ~>= 8, 9;
    is($x, "a", '~>= operator');
    is(@p[0],"a", "~>= operator parses as item assignment 1");
    is(@p[1],9, "~>= operator parses as item assignment 2");
}

# Tests of dwimming scalar/listiness of lhs

sub W () { substr(eval('want'), 0, 1) }

#?rakudo todo "want function"
{
    my $a;
    my @z = ($a = W, W);
    is($a, 'S',    'lhs treats $a as scalar');
    is(@z[0], 'S', 'lhs treats $a as scalar');
    is(@z[1], 'L', 'lhs treats $a as scalar');
}

#?rakudo skip "want function"
{
    package Foo;
    our $b;
    my @z = ($::('Foo::b') = W, W);
    is($b, 'S',    q/lhs treats $::('Foo::b') as scalar/);
    is(@z[0], 'S', q/lhs treats $::('Foo::b') as scalar/);
    is(@z[1], 'L', q/lhs treats $::('Foo::b') as scalar/);
}

#?rakudo todo "want function"
{
    my @z = ($Foo::c = W, W);
    is($Foo::c, 'S',    'lhs treats $Foo::c as scalar');
    is(@z[0], 'S', 'lhs treats $Foo::c as scalar');
    is(@z[1], 'L', 'lhs treats $Foo::c as scalar');
}

#?rakudo todo "want function"
{
    my @a;
    my @z = ($(@a[0]) = W, W);
    is(@a[0], 'S',    'lhs treats $(@a[0]) as scalar');
    is(@z[0], 'S', 'lhs treats $(@a[0]) as scalar');
    is(@z[1], 'L', 'lhs treats $(@a[0]) as scalar');
}

#?rakudo todo "want function"
{
    my $a;
    my @z = (($a) = W, W, W);
    is($a, 'L', 'lhs treats ($a) as list');
    is(@z, "L", 'lhs treats ($a) as list');
}

#?pugs eval 'notimpl'
#?rakudo todo "want function"
{
    my $a;
    my @z = (($a, *) = W, W, W);
    is($a, 'L', 'lhs treats ($a, *) as list');
    is(@z, "L L L", 'lhs treats ($a, *) as list');
}

#?rakudo skip "want function"
{
    my $a;
    my @z = (@$a = W, W, W);
    is($a, 'L L L', 'lhs treats @$a as list');
    ok(!defined(@z), 'lhs treats @$a as list');
}

#?rakudo skip "want function"
{
    my $a;
    my @z = ($a[] = W, W, W);
    is($a, 'L L L', 'lhs treats $a[] as list');
    ok(!defined(@z), 'lhs treats $a[] as list');
}

#?rakudo todo "want function"
{
    my $a;
    my $b;
    my @z = (($a,$b) = W, W, W);
    is($a, 'L',   'lhs treats ($a,$b) as list');
    is($b, 'L',   'lhs treats ($a,$b) as list');
    is(@z, "L L", 'lhs treats ($a,$b) as list');
}

{
    my @a;
    my @z = (@a[0] = W, W);
    #?rakudo 2 todo 'want function'
    is(@a, 'L',    'lhs treats @a[0] as list');
    is(@z[0], 'L', 'lhs treats @a[0] as list');
    ok(!defined(@z[1]), 'lhs treats @a[0] as list');
}

{
    my @a;
    my @z = (@a[0,] = W, W);
    #?rakudo 2 todo 'want function'
    is(@a, 'L',      'lhs treats @a[0,] as list');
    is(@z[0], 'L',   'lhs treats @a[0,] as list');
    ok(!defined(@z[1]), 'lhs treats @a[0,] as list');
}

{
    my %a;
    my @z = (%a<x> = W, W);
    #?rakudo 2 todo 'want function'
    is(%a{"x"}, 'L', 'lhs treats %a<x> as list');
    is(@z[0], 'L',   'lhs treats %a<x> as list');
    ok(!defined(@z[1]),   'lhs treats %a<x> as list');
}

#?rakudo todo "unknown reasons"
{
    my %a;
    my @z = (%a<x y z> = W, W, W);
    is(%a<x>, 'L',    'lhs treats %a<x y z> as list');
    is(%a<y>, 'L',    'lhs treats %a<x y z> as list');
    is(%a<z>, 'L',    'lhs treats %a<x y z> as list');
}

{
    my %a;
    my @z = (%a{'x'} = W, W);
    #?rakudo 2 todo "want function"
    is(%a{"x"}, 'L', q/lhs treats %a{'x'} as list/);
    is(@z[0], 'L',   q/lhs treats %a{'x'} as list/);
    ok(!defined(@z[1]),   q/lhs treats %a{'x'} as list/);
}

#?rakudo todo "want function"
{
    my %a;
    my @z = (%a{'x','y','z'} = W, W, W);
    is(%a<x>, 'L',    q/lhs treats %a{'x','y','z'} as list/);
    is(%a<y>, 'L',    q/lhs treats %a{'x','y','z'} as list/);
    is(%a<z>, 'L',    q/lhs treats %a{'x','y','z'} as list/);
    is(@z[0], 'L',    q/lhs treats %a{'x','y','z'} as list/);
    is(@z[1], 'L',    q/lhs treats %a{'x','y','z'} as list/);
    is(@z[2], 'L',    q/lhs treats %a{'x','y','z'} as list/);
}

#?rakudo todo "want function"
{
    my %a;
    my @z = (%a{'x'..'z'} = W, W, W);
    is(%a<x>, 'L',    q/lhs treats %a{'x'..'z'} as list/);
    is(%a<y>, 'L',    q/lhs treats %a{'x'..'z'} as list/);
    is(%a<z>, 'L',    q/lhs treats %a{'x'..'z'} as list/);
    is(@z[0], 'L',    q/lhs treats %a{'x'..'z'} as list/);
    is(@z[1], 'L',    q/lhs treats %a{'x'..'z'} as list/);
    is(@z[2], 'L',    q/lhs treats %a{'x'..'z'} as list/);
}

{
    my %a;
    my @z = (%a{'x' x 1} = W, W);
    #?rakudo 2 todo "want function"
    is(%a{"x"}, 'L', q/lhs treats %a{'x' x 1} as list/);
    is(@z[0], 'L',   q/lhs treats %a{'x' x 1} as list/);
    ok(!defined(@z[1]),   q/lhs treats %a{'x' x 1} as list/);
}

{
    my %a;
    my @z = (%a{'x' xx 1} = W, W, W);
    #?rakudo 2 todo "want function"
    is(%a<x>, 'L',    q/lhs treats %a{'x' xx 1} as list/);
    is(@z[0], 'L',    q/lhs treats %a{'x' xx 1} as list/);
    ok(!defined(@z[1]),  q/lhs treats %a{'x' xx 1} as list/);
}

{
    my @a;
    my $b = 0;
    my @z = (@a[$b] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',    'lhs treats @a[$b] as list');
    is(@z[0], 'L', 'lhs treats @a[$b] as list');
    ok(!defined(@z[1]), 'lhs treats @a[$b] as list');
}

{
    my @a;
    my $b = 0;
    my @z = (@a[$b,] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',      'lhs treats @a[$b,] as list');
    is(@z[0], 'L',   'lhs treats @a[$b,] as list');
    ok(!defined(@z[1]), 'lhs treats @a[$b,] as list');
}

{
    my @a;
    my @b = (0,1);
    my @z = (@a[@b] = W, W, W);
    #?rakudo 3 todo "want function"
    is(@a, 'L L',  'lhs treats @a[@b] as list');
    is(@z[0], 'L', 'lhs treats @a[@b] as list');
    is(@z[1], 'L', 'lhs treats @a[@b] as list');
    ok(!defined(@z[2]), 'lhs treats @a[@b] as list');
}

{
    my @a;
    my @b = (0,0);
    my $c = 1;
    my @z = (@a[@b[$c]] = W, W);
    #?rakudo 2 todo 'want function'
    is(@a, 'L',    'lhs treats @a[@b[$c]] as list');
    is(@z[0], 'L', 'lhs treats @a[@b[$c]] as list');
    #?rakudo todo 'unknown'
    is(!defined(@z[1]), 'lhs treats @a[@b[$c]] as list');
}

{
    my @a;
    my @b = (0,0);
    my $c = 1;
    my @z = (@a[@b[$c,]] = W, W);
    #?rakudo 2 todo 'want function'
    is(@a, 'L',      'lhs treats @a[@b[$c,]] as list');
    is(@z[0], 'L',   'lhs treats @a[@b[$c,]] as list');
    ok(!defined(@z[1]), 'lhs treats @a[@b[$c,]] as list');
}

#?rakudo skip "unknown reasons"
{
    my @a;
    my $b = 0;
    my sub foo { \@a }
    my @z = eval '(foo()[$b] = W, W)';
    is(@a, 'L',    'lhs treats foo()[$b] as list');
    is(@z[0], 'L', 'lhs treats foo()[$b] as list');
    ok(!defined(@z[1]), 'lhs treats foo()[$b] as list');
}

#?rakudo skip "want function"
{
    my @a;
    my $b = 0;
    my sub foo { \@a }
    my @z = eval '(foo()[$b,] = W, W)';
    is(@a, 'L',      'lhs treats foo()[$b,] as list');
    is(@z[0], 'L',   'lhs treats foo()[$b,] as list');
    ok(!defined(@z[1]), 'lhs treats foo()[$b,] as list');
}

#?rakudo skip "want function"
{
    my @a;
    my $b = 0;
    my sub foo { \@a }
    my @z = ($(@a[foo()[$b]]) = W, W);
    is(@a, 'S',    'lhs treats @a[foo()[$b]] as item');
    is(@z[0], 'S', 'lhs treats @a[foo()[$b]] as item');
    is(@z[1], 'L', 'lhs treats @a[foo()[$b]] as item');
}

#?rakudo skip "want function"
{
    my @a;
    my $b = 0;
    my sub foo { \@a }
    my @z = (@a[foo()[$b,]] = W, W);
    is(@a, 'L',      'lhs treats @a[foo()[$b,]] as list');
    is(@z[0], 'L',   'lhs treats @a[foo()[$b,]] as list');
    ok(!defined(@z[1]), 'lhs treats @a[foo()[$b,]] as list');
}

#?rakudo skip "want function"
{
    my @a;
    my sub foo { 0 }
    my @z = ($(@a[+foo()]) = W, W);
    is(@a, 'S',    'lhs treats @a[+foo()] as item');
    is(@z[0], 'S', 'lhs treats @a[+foo()] as item');
    is(@z[1], 'L', 'lhs treats @a[+foo()] as item');
}

#?rakudo skip "want function"
{
    my @a;
    my sub foo { '0' }
    my @z = (@a[~foo()] = W, W);
    is(@a, 'L',    'lhs treats @a[~foo()] as list');
    is(@z[0], 'L', 'lhs treats @a[~foo()] as list');
    ok(!defined(@z[1]), 'lhs treats @a[~foo()] as list');
}

#?rakudo skip "want function"
{
    my @a;
    my sub foo { 0 }
    my @z = (@a[?foo()] = W, W);
    is(@a, 'L',    'lhs treats @a[?foo()] as list');
    is(@z[0], 'L', 'lhs treats @a[?foo()] as list');
    ok(!defined(@z[1]), 'lhs treats @a[?foo()] as list');
}

#?rakudo skip "want function"
{
    my @a;
    my sub foo { 1 }
    my @z = (@a[!foo()] = W, W);
    is(@a, 'L',    'lhs treats @a[!foo()] as list');
    is(@z[0], 'L', 'lhs treats @a[!foo()] as list');
    ok(!defined(@z[1]), 'lhs treats @a[!foo()] as list');
}

#?rakudo skip "want function"
{
    my @a;
    my $b = 0;
    my sub foo { 0 }
    my @z = (@a[foo()] = W, W);
    is(@a, 'L',    'lhs treats @a[foo()] as list');
    is(@z[0], 'L', 'lhs treats @a[foo()] as list');
    ok(!defined(@z[1]), 'lhs treats @a[foo()] as list');
}

#?rakudo skip "want function"
{
    my @a;
    my $b = 0;
    my sub foo { 0,1 }
    my @z = (@a[foo()] = W, W);
    is(@a, 'L L',  'lhs treats @a[foo()] as list');
    is(@z[0], 'L', 'lhs treats @a[foo()] as list');
    is(@z[1], 'L', 'lhs treats @a[foo()] as list');
}

#?rakudo skip "want function"
{
    my %a;
    my sub foo { 0 }
    my @z = (%a{+foo()} = W, W);
    #?pugs todo 'bug'
    is(%a, 'L',    'lhs treats %a{+foo()} as list');
    is(@z[0], 'L', 'lhs treats %a{+foo()} as list');
    ok(!defined(@z[1]), 'lhs treats %a{+foo()} as list');
}

#?rakudo skip "want function"
{
    my %a;
    my sub foo { '0' }
    my @z = (%a{~foo()} = W, W);
    #?pugs todo 'bug'
    is(%a, 'L',    'lhs treats %a{~foo()} as list');
    is(@z[0], 'L', 'lhs treats %a{~foo()} as list');
    ok(!defined(@z[1]), 'lhs treats %a{~foo()} as list');
}

#?rakudo skip "want function"
{
    my %a;
    my sub foo { 0 }
    my @z = (%a{?foo()} = W, W);
    #?pugs todo 'bug'
    is(%a, 'L',    'lhs treats %a{?foo()} as list');
    is(@z[0], 'L', 'lhs treats %a{?foo()} as list');
    ok(!defined(@z[1]), 'lhs treats %a{?foo()} as list');
}

#?rakudo skip "want function"
{
    my %a;
    my sub foo { 1 }
    my @z = (%a{!foo()} = W, W);
    #?pugs todo 'bug'
    is(%a, 'L',    'lhs treats %a{!foo()} as list');
    is(@z[0], 'L', 'lhs treats %a{!foo()} as list');
    ok(@z[1] ~~ undef, 'lhs treats %a{!foo()} as list');
}

#?rakudo skip "want function"
{
    my %a;
    my $b = 0;
    my sub foo { 0, * }
    my @z = (%a{foo()} = W, W);
    is(%a{0}, 'L', 'lhs treats %a{foo()} as list');
    is(@z[0], 'L L', 'lhs treats %a{foo()} as list');
    ok(@z[1] ~~ undef, 'lhs treats %a{foo()} as list');
}

#?rakudo skip "my sub"
{
    my %a;
    my $b = 0;
    my sub foo { 0,1 }
    my @z = (%a{foo()} = W, W);
    is(%a{0}, 'L', 'lhs treats %a{foo()} as run-time list');
    is(%a{1}, 'L', 'lhs treats %a{foo()} as run-time list');
    is(@z[0], 'L', 'lhs treats %a{foo()} as run-time list');
    is(@z[1], 'L', 'lhs treats %a{foo()} as run-time list');
}

{
    my @a;
    my @z = (@a[0+0] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',    'lhs treats @a[0+0] as list');
    is(@z[0], 'L', 'lhs treats @a[0+0] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[0+0] as list');
}

{
    my @a;
    my @z = (@a[0*0] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',    'lhs treats @a[0*0] as list');
    is(@z[0], 'L', 'lhs treats @a[0*0] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[0*0] as list');
}

{
    my @a;
    my @z = (@a[0/1] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',    'lhs treats @a[0/1] as list');
    is(@z[0], 'L', 'lhs treats @a[0/1] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[0/1] as list');
}

{
    my @a;
    my @z = (@a[0*1**1] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',    'lhs treats @a[0*1**1] as list');
    is(@z[0], 'L', 'lhs treats @a[0*1**1] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[0*1**1] as list');
}

{
    my @a;
    my $b = 0;
    my @z = (@a[$b++] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',    'lhs treats @a[$b++] as list');
    is(@z[0], 'L', 'lhs treats @a[$b++] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[$b++] as list');
}

{
    my @a;
    my $b = 1;
    my @z = (@a[--$b] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',    'lhs treats @a[--$b] as list');
    is(@z[0], 'L', 'lhs treats @a[--$b] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[--$b] as list');
}

{
    my @a;
    my @z = (@a[0==1] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L L',    'lhs treats @a[0==1] as list (but coerce rhs list to one thing)');
    is(@z[0], 'L L', 'lhs treats @a[0==1] as list (but coerce rhs list to one thing)');
    ok(@z[1] ~~ undef, 'lhs treats @a[0==1] as list (but coerce rhs list to one thing)');
}

{
    my @a;
    my @z = (@a[rand] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L L',    'lhs treats @a[rand] as run-time list');
    is(@z[0], 'L L', 'lhs treats @a[rand] as run-time list');
    ok(@z[1] ~~ undef, 'lhs treats @a[rand] as run-time list');
}

{
    my @a;
    my @z = (@a[rand,] = W, W);
    #?rakudo 2 todo "want function"
    is(@a, 'L',      'lhs treats @a[rand,] as list');
    is(@z[0], 'L',   'lhs treats @a[rand,] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[rand,] as list');
}

#?rakudo skip "unknown reasons"
{
    my @a;
    my @z = (@a[(0|0).pick] = W, W);
    is(@a, 'L L',    'lhs treats @a[(0|0).pick] as list');
    is(@z[0], 'L L', 'lhs treats @a[(0|0).pick] as list');
    ok(@z[1] ~~ undef, 'lhs treats @a[(0|0).pick] as list');
}

# L<S03/Assignment metaoperators/",=">
#?rakudo skip ',='
{
    my @a = 1, 2;
    is  (@a ,= 3, 4).join('|'), '1|2|3|4', ',= on lists works the same as push (return value)';
    is  @a.join('|'), '1|2|3|4', ',= on lists works the same as push (effect on array)';
}

{
    my $s = 'abc';
    $s .= subst('b','d');
    is $s, 'adc', '.= on scalars works';

    my @a = 'abc';
    @a[0] .= subst('b','d');
    is @a[0], 'adc', '.= on array indexed values';

    my %h = x => 'abc';
    %h<x> .= subst('b','d');
    is %h<x>, 'adc', '.= on hash keyed values';
}

use v6;

use Test;

plan 20;

# L<S06/Required parameters/method:>
sub a_zero  ()           { };
sub a_one   ($a)         { };
sub a_two   ($a, $b)     { };
sub a_three ($a, $b, @c) { };
sub a_four  ($a, $b, @c, %d) { };

sub o_zero  ($x?, $y?)   { };
sub o_one   ($x, :$y)    { };
sub o_two   ($x, :$y!, :$z) { };

is &a_zero.arity,   0, '0 arity &sub';
is &a_one.arity,    1, '1 arity &sub';
is &a_two.arity,    2, '2 arity &sub';
is &a_three.arity,  3, '3 arity &sub';
is &a_four.arity,   4, '4 arity &foo';

is &o_zero.arity,   0, 'arity 0 sub with optional params';
is &o_one.arity,    1, 'arity 1 sub with optional params';
is &o_two.arity,    2, 'arity with optional and required named params';

# It's not really specced in what way (*@slurpy_params) should influence
# .arity. Also it's unclear what the result of &multisub.arity is.
# See the thread "&multisub.arity?" on p6l started by Ingo Blechschmidt for
# details:
# L<http://thread.gmane.org/gmane.comp.lang.perl.perl6.language/4915>

{
    is ({ $^a         }.arity), 1,
        "block with one placeholder var has .arity == 1";
    #?rakudo skip 'pointy block as expression'
    is (-> $a { $a         }.arity), 1,
        "pointy block with one placeholder var has .arity == 1";
    #?rakudo skip 'method calling syntax'
    is arity({ $^a,$^b     }:), 2,
        "block with two placeholder vars has .arity == 2";
    #?rakudo skip 'pointy block as expression'
    is arity(-> $a, $b { $a,$b     }:), 2,
        "pointy block with two placeholder vars has .arity == 2";
    #?rakudo skip 'method calling syntax'
    is arity({ $^a,$^b,$^c }:), 3,
        "block with three placeholder vars has .arity == 3";
    #?rakudo skip 'pointy block as expression'
    is arity(-> $a, $b, $c { $a,$b,$c }:), 3,
        "pointy block with three placeholder vars has .arity == 3";
}

#?rakudo skip 'method calling syntax'
{
    is arity({ my $k; $^a         }:), 1,
        "additional my() vars don't influence .arity calculation (1-1)";
    is arity({ my $k; $^a,$^b     }:), 2,
        "additional my() vars don't influence .arity calculation (1-2)";
    is arity({ my $k; $^a,$^b,$^c }:), 3,
        "additional my() vars don't influence .arity calculation (1-3)";
}

#?rakudo skip 'method calling syntax'
{
    is arity({ $^a;         my $k }:), 1,
        "additional my() vars don't influence .arity calculation (2-1)";
    is arity({ $^a,$^b;     my $k }:), 2,
        "additional my() vars don't influence .arity calculation (2-2)";
    is arity({ $^a,$^b,$^c; my $k }:), 3,
        "additional my() vars don't influence .arity calculation (2-3)";
}

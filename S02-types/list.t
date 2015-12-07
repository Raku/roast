use v6;
use Test;

plan 65;

isa-ok (5, 7, 8), List, '(5, 7, 8) is List';
is +(5, 7, 8), 3, 'prefix:<+> on a List';
is ~(5, 7, 8), '5 7 8', 'prefix:<~> on a List';
is (5, 7, 8).Str, '5 7 8', '.Str on a List';

# .perl
is ().perl, '()', '.perl on empty List';
#?niecza todo '.item.perl on empty List gives Match.ast shorthand'
is ().item.perl, '$()', '.item.perl on empty List';

# L<S02/Quoting forms/Elsewhere it is equivalent to a parenthesized list of strings>

isa-ok <5 7 8>, List, '<5 7 8> is List';
is +<5 7 8>, 3, 'prefix:<+> on an angle bracket List';
is ~<5 7 8>, '5 7 8', 'prefix:<~> on an angle bracket List';
is <5 7 8>.Str, '5 7 8', '.Str on an angle bracket List';

#?niecza 3 skip ".List NYI"
isa-ok (5, 7, 8).List, List, '.List returns a list';
is (5, 7, 8).List, [5,7,8], '.List contains the right items';
is (5, 7, 8).List.elems, 3, '.List contains the right number of elements';

is ?(), False, 'empty List is False';
is ?(1,2,3), True, 'non-empty List is True';

lives-ok { <5 7 8>[] }, 'can zen slice a List';

# WAS: RT #115282, modified for lolly brannch
is $(;).elems, 0, '$(;) parses, and is empty';

# .rotate
{
    my $p = <a b c d e>;
    is ~$p.rotate, 'b c d e a', 'List.rotate defaults to +1';
    is ~$p, 'a b c d e', 'original list unmodified';
    ok $p.rotate ~~ List, 'List.rotate returns a List';

    is ~$p.rotate(2), 'c d e a b', '.rotate(2)';
    is ~$p, 'a b c d e', 'original list still unmodified';

    is ~$p.rotate(-2), 'd e a b c', '.rotate(-2)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~$p.rotate(0), 'a b c d e', '.rotate(0)';
    is ~$p.rotate(5), 'a b c d e', '.rotate(5)';
    is ~$p.rotate(15), 'a b c d e', '.rotate(15)';

    is ~$p.rotate(7), 'c d e a b', '.rotate(7)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~$p.rotate(-8), 'c d e a b', '.rotate(-8)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';
} #14

# all the same but rotate() sub
{
    my $p = <a b c d e>;
    is ~rotate($p), 'b c d e a', 'rotate(@a)';
    is ~$p, 'a b c d e', 'original list unmodified';

    is ~rotate($p, 2), 'c d e a b', 'rotate(@a, 2)';
    is ~$p, 'a b c d e', 'original list still unmodified';

    is ~rotate($p, -2), 'd e a b c', 'rotate(@a, -2)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate($p, 0), 'a b c d e', 'rotate(@a, 0)';
    is ~rotate($p, 5), 'a b c d e', 'rotate(@a, 5)';
    is ~rotate($p, 15), 'a b c d e', 'rotate(@a, 15)';

    is ~rotate($p, 7), 'c d e a b', 'rotate(@a, 7)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate($p, -8), 'c d e a b', 'rotate(@a, -8)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';
} #13

# RT125677 Make sure List.rotate is Cool with stuff
{
    my $p = <a b c d e>;
    is ~$p.rotate('2'), 'c d e a b', '.rotate("2")';
    is ~$p.rotate(2.5), 'c d e a b', '.rotate(2.5)';
} #2

{
    ok <a b c> !=== <a b c>, 'a b c !=== a b c (List is not a value type)';
    ok (my $x1=42,1) !=== (42,1), '$x1 = 42,1 !=== 42,1';
    ok (my $x2=42,1) !=== (my $y=42,1), '$x2 = 42,1 !=== $y = 42,1';
    ok (my $x3=42,1) !=== (my $y2:=$x3,1), '$x3=42,1 !=== $y2 := $x3,1 (List is not a value type)';
} #4

{
    my $p = List.new( <a b c> );
    is $p.elems, 1, 'did we get the list';
    is $p, <a b c>, 'did we get what we put in';

    $p = List.new( 'a','b','c' );
    is $p.elems, 3, 'did we get the parameters';
    is $p, <a b c>, 'did we get what we put in';
} #4

#RT #116527
{
    role sidecat {};
    my @a = 1,2,3;
    my @b = @a.pick(*).sort.list but sidecat;
    is @b.gist, "[1 2 3]", "can gist a list with a role";
}

{
    for <push pop shift unshift append prepend> -> $method {
        throws-like { (1,2,3)."$method"(42) }, X::Immutable,
          method   => $method,
          typename => 'List',
        ;
    }
}

{
    is (1,2,3,4).sum, 10, 'can we do .sum on a List';
    is (.1,.2,.3,.4).sum, 1, 'even if they are not ints';
    is <1 2 3 4>.sum, 10, 'even if they are numified strings';
    throws-like { <a b c d>.sum }, X::Str::Numeric,
      reason => "base-10 number must begin with valid digits or '.'",
      'fail if they are non-numeric strings';
}

# vim: ft=perl6

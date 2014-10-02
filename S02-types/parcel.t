use v6;
use Test;

plan 52;

isa_ok (5, 7, 8), Parcel, '(5, 7, 8) is Parcel';
is +(5, 7, 8), 3, 'prefix:<+> on a Parcel';
is ~(5, 7, 8), '5 7 8', 'prefix:<~> on a Parcel';
is (5, 7, 8).Str, '5 7 8', '.Str on a Parcel';

# .perl
is ().perl, '()', '.perl on empty Parcel';
#?niecza todo '.item.perl on empty Parcel gives Match.ast shorthand'
is ().item.perl, '$( )', '.item.perl on empty Parcel';

# L<S02/Quoting forms/Elsewhere it is equivalent to a parenthesized list of strings>

isa_ok <5 7 8>, Parcel, '<5 7 8> is Parcel';
is +<5 7 8>, 3, 'prefix:<+> on an angle bracket Parcel';
is ~<5 7 8>, '5 7 8', 'prefix:<~> on an angle bracket Parcel';
is <5 7 8>.Str, '5 7 8', '.Str on an angle bracket Parcel';

#?niecza 3 skip ".Parcel NYI"
isa_ok (5, 7, 8).Parcel, Parcel, '.Parcel returns an parcel';
is (5, 7, 8).Parcel, [5,7,8], '.Parcel contains the right items';
is (5, 7, 8).Parcel.elems, 3, '.Parcel contains the right number of elements';

is ?(), False, 'empty Parcel is False';
is ?(1,2,3), True, 'non-empty Parcel is True';

lives_ok { <5 7 8>[] }, 'can zen slice a Parcel';

# WAS: RT #115282, modified for lolly brannch
is $(;).elems, 0, '$(;) parses, and is empty';

# .rotate
{
    my $p = <a b c d e>;
    is ~$p.rotate, 'b c d e a', 'Parcel.rotate defaults to +1';
    is ~$p, 'a b c d e', 'original parcel unmodified';
    ok $p.rotate ~~ Parcel, 'Parcel.rotate returns a Parcel';

    is ~$p.rotate(2), 'c d e a b', '.rotate(2)';
    is ~$p, 'a b c d e', 'original parcel still unmodified';

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
    is ~$p, 'a b c d e', 'original parcel unmodified';

    is ~rotate($p, 2), 'c d e a b', 'rotate(@a, 2)';
    is ~$p, 'a b c d e', 'original parcel still unmodified';

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

{
    cmp_ok <a b c>, '===', <a b c>, 'a b c === a b c';
    ok (my $x1=42,1) !=== (42,1), '$x1 = 42,1 !==== 42,1'; # !=== not an op
    ok (my $x2=42,1) !=== (my $y=42,1), '$x2 = 42,1 !==== $y = 42,1';
    cmp_ok (my $x3=42,1), '===', (my $y2:=$x3,1), '$x3=42,1 ==== $y2 := $x3,1';
} #4

{
    my $p = Parcel.new( <a b c> );
    is $p.elems, 1, 'did we get the list';
    is $p, <a b c>, 'did we get what we put in';

    $p = Parcel.new( 'a','b','c' );
    is $p.elems, 3, 'did we get the parameters';
    is $p, <a b c>, 'did we get what we put in';
} #4

# vim: ft=perl6

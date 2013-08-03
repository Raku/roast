use v6;

use Test;

plan 14;

=begin description

This test tests the C<squish> builtin and .squish method on Any/List.

=end description

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @array = <a b b c d e f f a>;
    is_deeply @array.squish,  <a b c d e f a>.list.item,
      "method form of squish works";
    is_deeply squish(@array), <a b c d e f a>.list.item,
      "subroutine form of squish works";
    is_deeply @array .= squish, [<a b c d e f a>],
      "inplace form of squish works";
    is_deeply @array, [<a b c d e f a>],
      "final result of in place";
} #4

{
    is_deeply squish(Any,'a', 'b', 'b', 'c', 'd', 'e', 'f', 'f', 'a'),
      (Any, <a b c d e f a>.list).list.item,
      'slurpy subroutine form of squish works';
} #1

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    is 42.squish, 42,    ".squish can work on scalars";
    is (42,).squish, 42, ".squish can work on one-elem arrays";
} #2

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my class A { method Str { '' } };
    is (A.new, A.new).squish.elems, 2, 'squish has === semantics for objects';
} #1

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @list = 1, "1";
    my @squish = squish(@list);
    is @squish, @list, "squish has === semantics for containers";
} #1

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @a := squish( 1..Inf );
    is @a[3], 4, "make sure squish is lazy";
} #1

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @array = <a b bb c d e f f a>;
    my $with  = -> $a, $b { substr($a,0,1) eq substr($b,0,1) };
    is_deeply @array.squish(:$with),  <a b c d e f a>.list.item,
      "method form of squish works";
    is_deeply squish(@array,:$with), <a b c d e f a>.list.item,
      "subroutine form of squish works";
    is_deeply @array .= squish(:$with), [<a b c d e f a>],
      "inplace form of squish works";
    is_deeply @array, [<a b c d e f a>],
      "final result of in place";
} #4

# vim: ft=perl6

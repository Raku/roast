use v6;

use Test;

plan 16;

=begin description

This test tests the C<pick> builtin. See S32::Containers#pick.

Previous discussions about pick.

L<"http://groups.google.com/group/perl.perl6.language/tree/browse_frm/thread/24e369fba3ed626e/4e893cad1016ed94?rnum=1&_done=%2Fgroup%2Fperl.perl6.language%2Fbrowse_frm%2Fthread%2F24e369fba3ed626e%2F6e6a2aad1dcc879d%3F#doc_2ed48e2376511fe3">

=end description

# L<S32::Containers/List/=item pick>

my @array = <a b c d>;
ok ?(@array.pick eq any <a b c d>), "pick works on arrays";

my $junc = (1|2|3);
#?rakudo skip 'dubious: pick on Junctions (unspecced?)'
ok ?(1|2|3 == $junc.pick), "pick works on junctions";

my @arr = <z z z>;

ok ~(@arr.pick(2)) eq 'z z',   'method pick with $num < +@values';
ok ~(@arr.pick(4)) eq 'z z z', 'method pick with $num > +@values';
#?pugs todo 'feature'
is ~(@arr.pick(4, :replace)), 'z z z z', 'method pick(:replace) with $num > +@values';

#?pugs 3 todo 'feature'
is ~(pick(2, :replace(False), @arr)), 'z z', 'sub pick with $num < +@values, explicit no-replace';
is pick(2, @arr), <z z>, 'sub pick with $num < +@values, implicit no-replace';
is pick(4, @arr), <z z z>, 'sub pick with $num > +@values';
#?rakudo skip "Calling values by name fails hard"
is pick(2, :values(@arr)), <z z>, 'sub pick with $num < +@values and named args';
is ~(pick(4, :replace, @arr)), 'z z z z', 'sub pick(:replace) with $num > +@values';

is (<a b c d>.pick(*).sort).Str, 'a b c d', 'pick(*) returns all the items in the array (but maybe not in order)';

{
  my @items = <1 2 3 4>;
  my @shuffled_items_10;
  push @shuffled_items_10, @items.pick(*) for ^10;
  isnt(@shuffled_items_10, @items xx 10,
       'pick(*) returned the items of the array in a random order');
}

is (0, 1).pick(*, :replace).[^10].elems, 10, '.pick(*, :replace) returns an answer';

{
    # Test that List.pick doesn't flatten array refs
    ok ?([[1, 2], [3, 4]].pick.join('|') eq any('1|2', '3|4')), '[[1,2],[3,4]].pick does not flatten';
    ok ?(~([[1, 2], [3, 4]].pick(*)) eq '1 2 3 4' | '3 4 1 2'), '[[1,2],[3,4]].pick(*) does not flatten';
}

{
    ok <5 5>.pick() == 5,
       '.pick() returns something can be used as single scalar';
}

# vim: ft=perl6

use v6;

use Test;

plan 15;

=begin description

This test tests the C<pick> builtin. See S29#pick.

Previous discussions about pick.

L<"http://groups.google.com/group/perl.perl6.language/tree/browse_frm/thread/24e369fba3ed626e/4e893cad1016ed94?rnum=1&_done=%2Fgroup%2Fperl.perl6.language%2Fbrowse_frm%2Fthread%2F24e369fba3ed626e%2F6e6a2aad1dcc879d%3F#doc_2ed48e2376511fe3"> 

=end description

# L<S29/List/=item pick>

my @array = <a b c d>;
ok ?(@array.pick eq any <a b c d>), "pick works on arrays";

my %hash = (a => 1);
#?rakudo 2 skip 'pick on hashes (?)'
is %hash.pick.key,   "a", "pick works on hashes (1)";
is %hash.pick.value, "1", "pick works on hashes (2)";

my $junc = (1|2|3);
#?rakudo skip 'dubious: pick on Junctions (unspecced?)'
ok ?(1|2|3 == $junc.pick), "pick works on junctions";

my @arr = <z z z>;

ok ~(@arr.pick(2)) eq 'z z',   'method pick with $num < +@values';
ok ~(@arr.pick(4)) eq 'z z z', 'method pick with $num > +@values';
#?pugs todo 'feature'
#?rakudo skip 'List.pick($count, :repl)'
ok ~(@arr.pick(4, :repl)), 'z z z z', 'method pick(:repl) with $num > +@values';

#?pugs 3 todo 'feature'
is pick(2, @arr), <z z>, 'sub pick with $num < +@values';
is pick(4, @arr), <z z z>, 'sub pick with $num > +@values';
is pick(4, :repl, @arr), <z z z z>, 'sub pick(:repl) with $num > +@values';

ok(~(<a b c d>.pick(*).sort) eq 'a b c d', 'pick(*) returns all the items in the array (but maybe not in order)');

{
  my @items = <1 2 3 4>;
  my @shuffled_items_10;
  push @shuffled_items_10, @items.pick(*) for ^10;
  isnt(@shuffled_items_10, @items xx 10,
       'pick(*) returned the items of the array in a random order');
}

my $c = 0;
my @value = gather {
  eval '
    for (0,1).pick(*, :repl) -> $v { take($v); leave if ++$c > 3; }
    ';
}

#?pugs todo 'feature'
#?rakudo todo 'lazy lists'
ok +@value == $c && $c, 'pick(*, :repl) is lazy';

{
    # Test that List.pick doesn't flatten array refs
    ok ?([[1, 2], [3, 4]].pick.[0].join('|') eq any('1|2', '3|4')), '[[1,2],[3,4]].pick does not flatten';
    ok ?(~([[1, 2], [3, 4]].pick(*)) eq '1 2 3 4' | '3 4 1 2'), '[[1,2],[3,4]].pick(*) does not flatten';

}

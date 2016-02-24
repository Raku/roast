use v6.c;
use Test;

plan 5;

=begin description

The C<:ex> and C<:x($count)> modifiers are orthogonal, and therefore 
can be combined.

Still lacking are tests for C<$/>, since the specs are not clear 
how the C<$/> looks like with the C<:x($count)> modifier.

=end description

#L<S05/Modifiers/"If followed by an x, it means repetition.">
#L<S05/Modifiers/"With the new :ex">

my $str = "abbb";
my regex rx { a b+ };

#?rakudo.jvm 4 skip 'RT #124279'
ok($str  ~~ m:ex:x(2)/<rx>/, "Simple combination of :x(2) and :exhaustive");
#?rakudo todo 'exhaustive capture too greedy RT #125133'
is(~$/[0],  "ab", 'First entry of prev. genenerated $/');
is(~$/[1], "abb", 'Second entry of prev. genenerated $/');
ok($str  ~~ m:ex:x(3)/<rx>/, "Simple combination of :x(3) and :exhaustive");
ok($str !~~ m:ex:x(4)/<rx>/, "Simple combination of :x(4) and :exhaustive");


# vim: syn=perl6 sw=4 ts=4 expandtab

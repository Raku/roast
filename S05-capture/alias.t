use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/named_cap.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 26;

# L<S05/Named scalar aliasing to subpatterns/If a named scalar alias is applied>

ok("abcd" ~~ m/a  $<foo>=(..)  d/, 'Hypothetical variable capture');
is(~$/<foo>, "bc", 'Hypothetical variable captured');

my $foo;
ok("abcd" ~~ m/a  $foo=(..)  d/, 'Package variable capture');
is(~$foo, "bc", 'Package variable captured');

# L<S05/Numbered scalar aliasing/If any numbered alias is used>

ok("abcd" ~~ m/a  $1=(.) $0=(.) d/, 'Reverse capture');
is(~$0, "c", '$0 captured');
is(~$1, "b", '$1 captured');

# L<S05/Named scalar aliases applied to non-capturing brackets/If a named scalar alias>
regex two {..}

ok("abcd" ~~ m/a  $<foo>=[<two>]  d/, 'Compound hypothetical capture');
is(~$/<two>, "bc", 'Implicit hypothetical variable captured');
is(~$/<foo>, "bc", 'Explicit hypothetical variable captured');

$foo = "";
ok("abcd" ~~ m/a  $foo=[<two>]  d/, 'Mixed capture');
is(~$/<two>, "bc", 'Implicit hypothetical variable captured');
is($foo, "bc", 'Explicit package variable captured');

ok("a cat_O_9_tails" ~~ m:s/<alpha> <ident>/, 'Standard captures' );
is(~$/<alpha>, "a", 'Captured <?alpha>' );
is(~$/<ident>, "cat_O_9_tails", 'Captured <?ident>' );

ok("Jon Lee" ~~ m:s/$<first>=(<.ident>) $<family>=(<ident>)/, 'Repeated standard captures' );
is(~$/<first>,  "Jon", 'Captured $first' );
is(~$/<family>, "Lee", 'Captured $family' );
is(~$/<ident>,  "Lee", 'Captured <ident>' );

ok("foo => 22" ~~ m:s/$0=(foo) '=>' (\d+) | $1=(\d+) '<=' $0=(foo) /, 'Pair match' );
is(~$0, 'foo', 'Key match' );
is(~$1, '22', 'Value match' );

ok("22 <= foo" ~~ m:s/$0=(foo) '=>' (\d+) | $1=(\d+) '<=' $0=(foo) /, 'Pair match');
is(~$0, 'foo', 'Reverse key match');
is(~$1, '22', 'Reverse value match');

# vim: ft=perl6

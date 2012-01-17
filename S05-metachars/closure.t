use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/codevars.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

# L<S05/Bracket rationalization/It now delimits an embedded closure>

plan 12;

{
    my $x = 3;
    my $y = 2;
    ok 'a' ~~ /. { $y = $x; 0 }/, 'can match and execute a closure';
    is $y, 3, 'could access and update outer lexicals';
}

#?rakudo skip 'assignment to match variables (dubious)'
#?niecza skip 'assigning to readonly value'
{
    ok("abc" ~~ m/a(bc){$<caught> = $0}/, 'Inner match');
    is(~$/<caught>, "bc", 'Inner caught');
}

my $caught = "oops!";
ok("abc" ~~ m/a(bc){$caught = $0}/, 'Outer match');
is($caught, "bc", 'Outer caught');

#?rakudo skip 'assignment to match variables (dubious)'
#?niecza skip 'assigning to readonly value'
{
    ok("abc" ~~ m/a(bc){$0 = uc $0}/, 'Numeric match');
    is($/, "abc", 'Numeric matched');
    is($0, "BC", 'Numeric caught');
}

#?rakudo skip 'make() inside closure'
{
    ok("abc" ~~ m/a(bc){make uc $0}/ , 'Zero match');
    #?niecza todo
    is($($/), "BC", 'Zero matched');
    is(~$0, "bc", 'One matched');
}

# vim: ft=perl6

use v6;

use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
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

# https://github.com/Raku/old-issue-tracker/issues/4101
#?rakudo skip 'assignment to match variables (dubious)'
{
    ok("abc" ~~ m/a(bc){$<caught> = $0}/, 'Inner match');
    is(~$/<caught>, "bc", 'Inner caught');
}

my $caught = "oops!";
ok("abc" ~~ m/a(bc){$caught = $0}/, 'Outer match');
is($caught, "bc", 'Outer caught');

# https://github.com/Raku/old-issue-tracker/issues/4102
#?rakudo skip 'assignment to match variables (dubious)'
{
    ok("abc" ~~ m/a(bc){$0 = uc $0}/, 'Numeric match');
    is($/, "abc", 'Numeric matched');
    is($0, "BC", 'Numeric caught');
}

{
    ok("abc" ~~ m/a(bc){make uc $0}/ , 'Zero match');
    #?rakudo todo 'make() inside closure'
    is($($/), "BC", 'Zero matched');
    is(~$0, "bc", 'One matched');
}

# vim: expandtab shiftwidth=4

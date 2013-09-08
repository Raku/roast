use v6;
use Test;

#?niecza emit plan 8; #
plan 9;

# this test file contains tests for line numbers, among other things
# so it's extremely important not to randomly insert or delete lines.

my $baseline = 10;

isa_ok callframe(), CallFrame, 'callframe() returns a CallFrame';

sub f() {
    #?rakudo.jvm todo "nigh"
    is callframe().line, $baseline + 5, 'callframe().line';
    ok callframe().file ~~ /« callframe »/, '.file';

    #?rakudo skip 'Unable to resolve method inline in type CallFrame'
    #?niecza skip 'Unable to resolve method inline in type CallFrame'
    nok callframe().inline, 'explicitly entered block (.inline)';

    # Note:  According to S02, these should probably fail unless
    # $x is marked 'is dynamic'.  We allow it for now since there's
    # still some uncertainty in the spec in S06, though.
    #?niecza skip 'Unable to resolve method my in type CallFrame'
    is callframe(1).my.<$x>, 42, 'can access outer lexicals via .my';
    #?niecza emit #
    callframe(1).my.<$x> = 23;

    #?niecza skip 'Unable to resolve method my in type CallFrame'
    is callframe(1).my.<$y>, 353, 'can access outer lexicals via .my';
    #?niecza emit #
    dies_ok { callframe(1).my.<$y> = 768 }, 'cannot mutate without is dynamic';;
}

my $x is dynamic = 42;
my $y = 353;

f();

#?niecza todo 'needs .my'
is $x,  23, '$x successfully modified';
is $y, 353, '$y not modified';

done();

# vim: ft=perl6

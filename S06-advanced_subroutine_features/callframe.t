use v6;
use Test;

plan *;

# this test file contains tests for line numbers, among other things
# so it's extremely important not to randomly insert or delete lines.


my $baseline = 10;

isa_ok callframe(), CallFrame, 'callframe() returns a CallFrame';

sub f() {
    is callframe().line, $baseline + 5, 'callframe().line';
    ok callframe().file ~~ /« callframe »/, '.file';

    #?rakudo skip '.inline'
    nok callframe().inline, 'explicitly entered block (.inline)';

    is callframe(1).my.<$x>, 42, 'can access outer lexicals via .my';
    # don't call dies_ok { callframe(1).my.<$x> = 1 } here,
    # because we don't know how many callframes dies_ok involves;
    my $pad = callframe(1).my;
    #?rakudo todo 'ro-ness of pads'
    dies_ok { $pad<$x> = 23 }, 'Cannot modify outer lexicals';
}

my $x = 42;

f();

is $x, 42, '$x remained unmodified';

done_testing();

# vim: ft=perl6 number

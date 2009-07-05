use v6;

use Test;

plan 12;

# L<S04/"Statement-ending blocks"/"will terminate a statement">

# the 'empty statement' case responsible for the creation of this test file
eval_lives_ok(';', 'empty statement');

eval_lives_ok('my $x = 2', 'simple statement no semi');
eval_lives_ok('my $x =
9', 'simple statement on two lines no semi');
eval_lives_ok('my $x = 2;', 'simple statement with semi');
eval_lives_ok('{my $x = 2}', 'end of closure terminator');
eval_lives_ok('{my $x =
2;}', 'double terminator');
eval_lives_ok(';my $x = 2;{my $x = 2;;};', 'extra terminators');

eval_dies_ok('{my $x = 2;', 'open closure');
eval_dies_ok('my $x = ', 'incomplete expression');

#?rakudo skip 'parsing do { ... } + 1'
{
    my $x = do {
        10
    } + 1;

    is($x, 11, "'} + 1' is in a single statement");

    my $y = do {
        10
    }
    + 1;

# old: L<A04/"RFC 022: Control flow: Builtin switch statement" /the final curly is on a line by itself/>

    is($y, 10, "}\\n + 1 are two statements");

    my $z = [];
    eval q'
        $z = [ do { 1 }
                + 2 ];
    ';

    #?pugs todo 'parsing'
    is($z[0], 3, 'auto-curly doesn\'t apply unless we\'re at top level');

}

use v6;

use Test;

plan 15;

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

{
    my $x = do {
        10
    } + 1;

    is($x, 11, "'} + 1' is in a single statement");

    my $y = do {
        10
    }
    + 1;

    is($y, 10, "}\\n + 1 are two statements");

    my $z = [];
    eval q'
        $z = [ do { 1 }
                + 2 ];
    ';

    #?pugs todo
    is($z[0], 2, 'auto-curly applies inside array composer');
}

# There's *no* ";" before the "\n", but pugs parsed it nevertheless!
# (and there s no infix:<is> either)
eval_dies_ok "42 if 23\nis 50; 1",
    "if postfix modifier and is() is parsed correctly";

# not sure this belong here, suggestions for better places are welcome
eval_dies_ok '(1) { $foo = 2 }', 'parens do not eat spaces after them';

# RT #79964
#?pugs todo
eval_lives_ok q:b"my &f;\nsub g() { }\n&f;", 'implicit terminator before & sigil';

# vim: ft=perl6

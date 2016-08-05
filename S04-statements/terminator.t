use v6;

use Test;

plan 20;

# L<S04/"Statement-ending blocks"/"will terminate a statement">

# the 'empty statement' case responsible for the creation of this test file
eval-lives-ok(';', 'empty statement');

eval-lives-ok('my $x = 2', 'simple statement no semi');
eval-lives-ok('my $x =
9', 'simple statement on two lines no semi');
eval-lives-ok('my $x = 2;', 'simple statement with semi');
eval-lives-ok('{my $x = 2}', 'end of closure terminator');
eval-lives-ok('{my $x =
2;}', 'double terminator');
eval-lives-ok(';my $x = 2;{my $x = 2;;};', 'extra terminators');

#?rakudo.jvm todo 'got: X::AdHoc; StringIndexOutOfBoundsException: String index out of range: -1'
throws-like '{my $x = 2;', X::Syntax::Missing, 'open closure';
throws-like 'my $x = ', X::Syntax::Malformed, 'incomplete expression';

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
    EVAL q'
        $z = do { 1 }
                + 2;
    ';

    is($z, 1, 'auto-curly applies inside array composer');
}

throws-like "42 if 23\nis 50; 1", X::Syntax::Confused,
    "if postfix modifier and is() is parsed correctly";

# not sure this belong here, suggestions for better places are welcome
throws-like '(1) { $foo = 2 }', Exception, 'parens do not eat spaces after them';

# RT #79964
eval-lives-ok q:b"my &f;\nsub g() { }\n&f;", 'implicit terminator before & sigil';

# not sure this belong here, suggestions for better places are welcome
# RT #115842
{
    eval-lives-ok 'my @ := 0,', 'trailing comma allowed (1)';
    eval-lives-ok 'my @ := 0, ;', 'trailing comma allowed (2)';
    eval-lives-ok 'my @array = 1, 2, 3, ;', 'trailing comma allowed (3)';
    eval-lives-ok '1, 2, 3,', 'trailing comma allowed (4)';
    eval-lives-ok '0,', 'trailing comma allowed (5)';
}

# vim: ft=perl6

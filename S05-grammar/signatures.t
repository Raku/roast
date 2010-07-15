use v6;

use Test;

plan 2;

# L<S05/Extensible metasyntax (C<< <...> >>)/If the first character is a colon>

grammar Grammar::With::Signatures {
    token TOP {
        <fred(1)>
        <fred: 2, 3>
    }

    token fred($arg, $bar?) {    #OK not used
        | { $arg == 1 } 'bar'
        | { $arg == 2 } 'foo'
    }
}

ok(Grammar::With::Signatures.parse("barfoo"), 'barfoo matches');
ok(Grammar::With::Signatures.parse("foobar"), 'foobar doesnt match');

# vim: ft=perl6

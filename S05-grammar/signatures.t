use v6;

use Test;

plan 10;

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

# RT #113544
{
    grammar AllTheArgKinds {
        token TOP {
            <.nameds(a => 1, :b(2))>
            <.flatpos(|[3,4,5])>
            <.flatnamed(|{ c => 6, d => 7 })>
        }

        token nameds(:$a, :$b) {
            {
                is $a, 1, 'named arg passed in subrule call with => syntax';
                is $b, 2, 'named arg passed in subrule call with colonpair syntax';
            }
            a
        }

        token flatpos($a, $b, $c) {
            {
                is $a, 3, 'flattened positional arg in subrule call (1)';
                is $b, 4, 'flattened positional arg in subrule call (2)';
                is $c, 5, 'flattened positional arg in subrule call (3)';
            }
            b
        }

        token flatnamed(:$c, :$d) {
            {
                is $c, 6, 'flattening named arg in subrule call (1)';
                is $d, 7, 'flattening named arg in subrule call (2)';
            }
            c
        }
    }
    ok AllTheArgKinds.parse('abc'), 'Grammar with various subrule arg passings parsed';
}

# vim: ft=perl6

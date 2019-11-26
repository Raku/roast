use v6;
use Test;

plan 2;

unless "a" ~~ rx:P5/a/ {
    skip-rest "skipped tests - P5 regex support appears to be missing";
    exit;
}

subtest 'named captures' => { plan 7;
    sub test-cap (\c, \v, $desc) {
        subtest $desc => { plan 2;
            isa-ok c, Capture, 'correct type';
            is     c, v,       'correct value';
        }
    }

    subtest 'one named (?<>) capture' => { plan 2;
        ok 'foo' ~~ m:P5/(?<meow>.+)/, 'matched';
        test-cap $<meow>, 'foo', 'named capture';
    }
    subtest 'two named (?<>) captures' => { plan 3;
        ok 'fooBAR' ~~ m:P5/(?<meow>[a-z]+)(?<moo>[A-Z]+)/, 'matched';
        test-cap $<meow>, 'foo', 'first named capture';
        test-cap $<moo>,  'BAR', 'second named capture';
    }
    subtest 'two named (?<>) + one positional captures' => { plan 4;
        ok 'foo42BAR' ~~ m:P5/(?<meow>[a-z]+)(\d+)(?<moo>[A-Z]+)/, 'matched';
        test-cap $/[0],   '42',  'positional capture';
        test-cap $<meow>, 'foo', 'first named capture';
        test-cap $<moo>,  'BAR', 'second named capture';
    }

    subtest ｢one named (?'') capture｣ => { plan 2;
        ok 'foo' ~~ m:P5/(?'meow'.+)/, 'matched';
        test-cap $<meow>, 'foo', 'named capture';
    }
    subtest ｢two named (?'') captures｣ => { plan 3;
        ok 'fooBAR' ~~ m:P5/(?'meow'[a-z]+)(?'moo'[A-Z]+)/, 'matched';
        test-cap $<meow>, 'foo', 'first named capture';
        test-cap $<moo>,  'BAR', 'second named capture';
    }
    subtest ｢two named (?'') + one positional captures｣ => { plan 4;
        ok 'foo42BAR' ~~ m:P5/(?'meow'[a-z]+)(\d+)(?'moo'[A-Z]+)/, 'matched';
        test-cap $/[0],   '42',  'positional capture';
        test-cap $<meow>, 'foo', 'first named capture';
        test-cap $<moo>,  'BAR', 'second named capture';
    }

    subtest ｢named (?'') + named (?<>) + one positional captures｣ => { plan 4;
        ok 'foo42BAR' ~~ m:P5/(?<meow>[a-z]+)(\d+)(?'moo'[A-Z]+)/, 'matched';
        test-cap $/[0],   '42',  'positional capture';
        test-cap $<meow>, 'foo', 'first named (?<>) capture';
        test-cap $<moo>,  'BAR', ｢second named (?'') capture｣;
    }
}

subtest 'conditional expressions' => { plan 2;
    subtest '(?(condition)yes-pattern|no-pattern)' => { plan 4;
        ok !("AC" ~~ rx:P5/(?:A|(B))(?(1)C|D)/), 'Conditional no-pattern is used, causing match to fail.';
        ok "AD" ~~ rx:P5/(?:A|(B))(?(1)C|D)/, 'Conditional no-pattern works.';
        #?rakudo 2 todo "P5 regex conditionals not working"
        ok "BC" ~~ rx:P5/(?:A|(B))(?(1)C|D)/, 'Conditional yes-pattern works.';
        ok !("BD" ~~ rx:P5/(?:A|(B))(?(1)C|D)/), 'Conditional yes-pattern is used, causing match to fail.';
    }

    subtest '(?(condition)yes-pattern)' => { plan 2;
        ok !("B" ~~ rx:P5/(B)?(?(1)C)/), 'Conditional without no-pattern works, causing match to fail.';
        #?rakudo todo "P5 regex conditionals not working"
        ok "BC" ~~ rx:P5/(B)?(?(1)C)/, 'Conditional without no-pattern works.';
    }
}

# vim: ft=perl6

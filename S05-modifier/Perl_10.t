use v6;
use Test;

plan 1;

unless "a" ~~ rx:P5/a/ {
    skip-rest "skipped tests - P5 regex support appears to be missing";
    exit;
}

subtest 'named captures' => { plan 7;
    sub test-cap (\c, \v, $desc) {
        subtest $desc => { plan 2;
            isa-ok c, Match, 'correct type';
            is     c, v,     'correct value';
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

# vim: expandtab shiftwidth=4

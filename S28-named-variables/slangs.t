use v6;

use Test;

plan 6;

# L<S02/Slangs/>

#?rakudo: 6 skip "Non-declarative sigil is missing its name"
ok(defined($~MAIN),    '$~MAIN is defined');
ok(defined($~Quote),   '$~Quote is defined');
ok(defined($~Quasi),   '$~Quasi is defined');
ok(defined($~Regex),   '$~Regex is defined');
ok(defined($~Trans),   '$~Trans is defined');
ok(defined($~P5Regex), '$~P5Regex is defined');

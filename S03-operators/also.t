use v6;
use Test;
plan 8;

# L<S03/"Junctive and (all) precedence"/"infix:<&>">

ok ?(1 S& 2),         "basic infix:<S&>";
ok ?(1 S& 2 S& 3), "basic infix:<S&> (multiple S&'s)";
# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
ok !(0 S& 1),         "S& has and-semantics (first term 0)";
# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
ok !(1 S& 0),         "also has and-semantics (second term 0)";

my $x = '';

ok ?('a' ~~ { $x ~= "b"; True } S& { $x ~= "c"; True }), 'S& with two blocks';
# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
is $x, 'bc', 'blocks called in the right order';

my $executed = 0;

# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
ok !('a' ~~ 'b' S& { $executed = 1; True }), 'and semantics';
ok !$executed,                            'short-circuit';

# vim: expandtab shiftwidth=4

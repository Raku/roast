use v6;
use Test;

# The tests in this file ensure certain constructs die with a decent error
# instead of hanging or crashing by spilling compiler guts.
#
# Since there's yet no existing behaviour for some of such combinations,
# X::Multi::NoMatch or similar exceptions are thrown.
# This APPENDIX test file is for such tests.

plan 16;

# https://github.com/Raku/old-issue-tracker/issues/5710
{
    throws-like { [].splice: 0, [] }, X::Multi::NoMatch,
        '.splice(offset, array) throws';
    throws-like { [].splice: 0e0, 0 }, X::Multi::NoMatch,
        '.splice(wrong type offset...) throws';
}


# https://github.com/rakudo/rakudo/issues/1644
throws-like ｢Lock.protect: %()｣, X::Multi::NoMatch,
    'Lock.protect with wrong args gives sane error';
throws-like ｢Lock::Async.protect: %()｣, X::Multi::NoMatch,
    'Lock::Async.protect with wrong args gives sane error';
throws-like { Proc::Async.new }, X::Multi::NoMatch,
    'attempting to create Proc::Async with wrong arguments throws';

# https://irclog.perlgeek.de/perl6-dev/2016-11-26#i_13630780
throws-like ｢"".subst｣, X::Multi::NoMatch, '.subst with no arguments throws';

throws-like { $*OUT.printf }, Exception, '.printf call without args';

# https://github.com/rakudo/rakudo/commit/742573724c
dies-ok { 42.words: |<bunch of incorrect args> },
    'no infinite loop when given wrong args to Cool.words';
# https://github.com/rakudo/rakudo/commit/742573724c
dies-ok { 42.lines: |<bunch of incorrect args> },
    'no infinite loop when given wrong args to Cool.lines';

throws-like { "".match: Nil }, X::Multi::NoMatch,
    '.match with Nil matcher does not hang';

# https://github.com/Raku/old-issue-tracker/issues/6259
{
    throws-like { Pair.new: <foo bar ber meow>, <meows>, 42 }, X::Multi::NoMatch,
        'Pair.new with wrong positional args does not go to Mu.new';
    throws-like { Pair.new: :42a                            }, X::Multi::NoMatch,
        'Pair.new with wrong named args does not go to Mu.new';
}

# https://github.com/Raku/old-issue-tracker/issues/6308
subtest "Junction.new does not use Mu.new's candidates" => {
    plan 3;
    throws-like { Junction.new: 42      }, X::Multi::NoMatch, 'positional';
    throws-like { Junction.new: :42meow }, X::Multi::NoMatch, 'named';
    throws-like { Junction.new          }, X::Multi::NoMatch, 'no args';
}

throws-like { Int.new: <a b c>, 42, 'meow', 'wrong', 'args' },
    X::Multi::NoMatch,
'does not incorrectly say that .new can only take named args';

{
    try Range.new: 'meow', 'meow', 'meow', :meow, 'meow';
    cmp-ok $!, '!~~', X::Constructor::Positional,
        'Range.new with wrong args does not claim it takes only named args';
}

# https://github.com/Raku/old-issue-tracker/issues/4921
dies-ok { Date.new(Int, 1, 1) },
    'dies when its year is given as an Int type object';

# vim: expandtab shiftwidth=4

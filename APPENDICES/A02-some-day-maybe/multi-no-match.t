use v6;
use Test;

# The tests in this file ensure certain constructs die with a decent error
# instead of hanging or crashing by spilling compiler guts.
#
# Since there's yet no existing behaviour for some of such combinations,
# X::Multi::NoMatch is thrown. This APPENDIX test file is for such tests.

plan 6;

{ # RT #129773
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

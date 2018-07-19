use v6;
use Test;

# The tests in this file ensure certain constructs die with a decent error
# instead of hanging or crashing by spilling compiler guts.
#
# Since there's yet no existing behaviour for some of such combinations,
# X::Multi::NoMatch is thrown. This APPENDIX test file is for such tests.

plan 2;

{ # RT #129773
    throws-like { [].splice: 0, [] }, X::Multi::NoMatch,
        '.splice(offset, array) throws';
    throws-like { [].splice: 0e0, 0 }, X::Multi::NoMatch,
        '.splice(wrong type offset...) throws';
}

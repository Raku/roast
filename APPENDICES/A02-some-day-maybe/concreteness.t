use v6;
use Test;

# The tests in this file ensure certain constructs die with a decent error
# instead of hanging or crashing by spilling compiler guts.
#
# Since there's yet no existing behaviour for some of such combinations,
# X::Parameter::InvalidConcreteness is thrown.
# This APPENDIX test file is for such tests.

plan 1;

throws-like ｢Supply.skip｣, X::Parameter::InvalidConcreteness, 'Supply:U.skip';

# vim: expandtab shiftwidth=4

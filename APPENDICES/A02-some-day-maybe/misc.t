use v6;
use Test;

# The tests in this file ensure certain constructs die with a decent error
# instead of hanging or crashing by spilling compiler guts.
#
# Since there's yet no existing behaviour for some of such combinations,
# yet it might exist in the future, this APPENDIX test file is for such tests.

plan 1;

# https://github.com/rakudo/rakudo/issues/1476
throws-like ｢*+42:foo｣, X::Syntax::Adverb, :what{.so},
    'error in Whatever closure with adverb mentions what cannot be adverbed';

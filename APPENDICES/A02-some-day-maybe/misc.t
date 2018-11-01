use v6;
use lib $?FILE.IO.parent(3).add: 'packages';
use Test;
use Test::Util;

# The tests in this file ensure certain constructs die with a decent error
# instead of hanging or crashing by spilling compiler guts.
#
# Since there's yet no existing behaviour for some of such combinations,
# yet it might exist in the future, this APPENDIX test file is for such tests.

plan 6;

# https://github.com/rakudo/rakudo/issues/1476
throws-like ｢*+42:foo｣, X::Syntax::Adverb, :what{.so},
    'error in Whatever closure with adverb mentions what cannot be adverbed';

# RT #131414
subtest 'same exception with and without type smiley for failing coercion on var' => {
    plan 3;
    my \XSVB = X::Syntax::Variable::BadType;
    throws-like ｢class { has Int() $.x = "42"}.new.x｣,           XSVB, 'no type smiley';
    throws-like ｢class { has Int:D() $.x = "42"}.new.x｣,         XSVB, ':D (1)';
    throws-like ｢class { has Int:D() $.x = "42"}.new(:x("43"))｣, XSVB, ':D (2)';
}

subtest 'attempting to use defaults with slurpy parameters throws' => {
    plan +my @slurpies = <*@  **@  +@  |  +a |c  *%>;
    throws-like '-> \qq[$_] = 42 {}()', X::Parameter::Default,
        $_ ~ ' slurpy with default throws'
    for @slurpies;
}

{ # RT#126979
    my @a[;];
    pass 'shaped array declaration without numbers does not infini-loop';
}

fails-like ｢'a' x Inf｣, X::NYI, 'repeating with Inf is NYI';

group-of 4 => '.pick/.grab/.kxxv with undecided semantics' => {
    my $m1 = MixHash.new("a", "b", "b");
    throws-like { $m1.pick }, Exception, '.pick does not work on MixHash';

    my $m2 = <a b b c c c>.MixHash;
    throws-like { $m2.grab }, Exception, 'cannot call .grab on a MixHash';
    throws-like { for $m2.kxxv -> \k { say k } }, Exception,
        'cannot call kxxv on MixHash';
    throws-like { for $m2.Mix.kxxv -> \k { say k } }, Exception,
        'cannot call kxxv on Mix';

}

use v6;
use Test;
use lib $?FILE.IO.parent(3).add("packages/Test-Helpers");
use Test::Util;

plan 18;

# https://github.com/Raku/old-issue-tracker/issues/4495
throws-like '2**10000000000', X::Numeric::Overflow,
    'attempting to raise to a huge power throws';
throws-like '2**-10000000000', X::Numeric::Underflow,
    'attempting to raise to a huge negative power throws';

# https://github.com/Raku/old-issue-tracker/issues/5893
throws-like '2**-999999', X::Numeric::Underflow,
    'attempting to raise to a large negative power throws';

{
    my $large-even = 4553535345364535345634543534;
    my $large-odd  = 4553535345364535345634543533;
    throws-like "  2  ** $large-even", X::Numeric::Overflow,
        " 2 ** $large-even";
    throws-like "(-2) ** $large-even", X::Numeric::Overflow,
        "-2 ** $large-even";
    throws-like "(-2) ** $large-odd",  X::Numeric::Overflow,
        "-2 ** $large-odd";
}

throws-like '2⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵',    X::Numeric::Overflow,
    '2⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ throws';
throws-like '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴', X::Numeric::Overflow,
    '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴ throws';
throws-like '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵', X::Numeric::Overflow,
    '(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ throws';

#?rakudo.jvm 2 skip 'implementation specific limit'
#?rakudo.js 2 skip 'implementation specific limit'
# https://github.com/Raku/old-issue-tracker/issues/2751
# if no throwage happens, as is wanted, the program will take forever to run
# so we wait for 2 seconds, then print success message and exit; if the throw
# occurs, the Promise won't have a chance to print the success message.
is_run ｢start { sleep 2; say ‘pass’; exit }; EVAL ‘say 1.0000001 ** (10 ** 8)’｣,
    {:out("pass\n"), :err(''), :0status },
'raising a Rat to largish power does not throw';

throws-like 'say 1.0000001 ** (10 ** 90000)',
    X::Numeric::Overflow, "raising a Rat to a very large number throws";

# https://github.com/rakudo/rakudo/commit/d1729da26a
{
    fails-like ｢<1/50000000000000> ** 5000000000000｣,  X::Numeric::Overflow,
        'rat (small nu / large de) to large power';
    fails-like ｢<1/50000000000000> ** -5000000000000｣, X::Numeric::Underflow,
        'rat (small nu / large de) to large negative power';
    fails-like ｢<50000000000000/1> ** 5000000000000｣,  X::Numeric::Overflow,
        'rat (large nu / small de) to large power';
    fails-like ｢<50000000000000/1> ** -5000000000000｣, X::Numeric::Underflow,
        'rat (large nu / small de) to large negative power';
}

# https://github.com/Raku/old-issue-tracker/issues/3319
if $?BITS >= 64 { 
    my int $low  = 10**15;
    my int $high = 2**60 - 1;
    is $low, 1_000_000_000_000_000,
        'int does not get confused with goldilocks number (low)';
    is $high, 1_152_921_504_606_846_975,
        'int does not get confused with goldilocks number (high)';
}
else {
    skip "this test doesn't make sense on 32bit platforms", 2;
}

# https://github.com/Raku/old-issue-tracker/issues/4471
# https://github.com/Raku/old-issue-tracker/issues/5127
#?rakudo.moar 1 skip 'overflow exception is not thrown on OSX RT #127500'
throws-like { 2 ** 99999999999999999999999999999999999 }, X::Numeric::Overflow,
    'extremely large exponents must throw numeric overflow';

# vim: expandtab shiftwidth=4

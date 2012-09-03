use v6;

use Test;

plan 13;

# L<S04/Exceptions/The fail function>

{
  # "use fatal" is not standard, so we don't have to disable it here
  my $was_after_fail  = 0;
  my $was_before_fail = 0;
  my $sub = sub { $was_before_fail++; my $exception = fail 42; $was_after_fail++ };    #OK not used

  my $unthrown_exception = $sub();
  # Note: We don't further access $unthrown_exception, so it doesn't get thrown
  is $was_before_fail, 1, "fail() doesn't cause our sub to not get executed";
  is $was_after_fail,  0, "fail() causes our sub to return (1)";
}

{
  my $was_after_fail = 0;
  my $was_after_sub  = 0;
  my $sub = sub { fail 42; $was_after_fail++ };

  use fatal;
  try { $sub(); $was_after_sub++ };

  is $was_after_fail, 0, "fail() causes our sub to return (2)";
  is $was_after_sub,  0, "fail() causes our try to die";
}

# RT #64990
#?rakudo skip 'RT 64990'
{
    our Int sub rt64990 { fail() }
    ok rt64990() ~~ Failure, 'sub typed Int can fail()';

    our Int sub repeat { return fail() }
    ok repeat() ~~ Failure, 'sub typed Int can return Failure';
}

# RT #70229
{
    sub rt70229 { return fail() }
    my $rt70229 = rt70229();
    ok $rt70229 ~~ Failure, 'got a Failure';
    dies_ok { ~$rt70229 }, 'attempt to stringify Failure dies';
}

# RT #77946
{
    sub rt77946 { return fail() }
    my $rt77946 = rt77946();
    isa_ok ?$rt77946, Bool, '?Failure returns a Bool';
    isa_ok $rt77946.defined, Bool, 'Failure.defined returns a Bool';
}

# RT #106832
{
    my $f = (sub { fail('foo') }).();
    is $f.exception, 'foo', 'can extract exception from Failure';
    isa_ok $f.exception, Exception, '... and it is an Exception';
}

{
    class AnEx is Exception { };
    my $f = (sub f { fail AnEx.new }).();  #OK not used
    isa_ok $f.exception, AnEx, 'can fail() typed exceptions';
}

done;

# vim: ft=perl6

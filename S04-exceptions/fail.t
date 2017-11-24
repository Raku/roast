use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 35;

# L<S04/Exceptions/The fail function>

given (Failure.new()) {
  .defined;
  is .exception.message, "Failed", 'Default message for Failure is "Failed" without $!';
}

{
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
    dies-ok { ~$rt70229 }, 'attempt to stringify Failure dies';
}

# RT #77946
{
    sub rt77946 { return fail() }
    my $rt77946 = rt77946();
    isa-ok ?$rt77946, Bool, '?Failure returns a Bool';
    isa-ok $rt77946.defined, Bool, 'Failure.defined returns a Bool';
}

# RT #106832
{
    my $f = (sub { fail('foo') }).();
    is $f.exception, 'foo', 'can extract exception from Failure';
    isa-ok $f.exception, Exception, '... and it is an Exception';
}

{
    class AnEx is Exception { };
    my $f = (sub f { fail AnEx.new }).();  #OK not used
    isa-ok $f.exception, AnEx, 'can fail() typed exceptions';
}

{
    sub it-will-fail() { fail 'whale' }
    dies-ok { use fatal; my $x = it-will-fail(); 1 }, 'use fatal causes call to die';
    lives-ok { use fatal; my $x = it-will-fail() // 0; 1 }, 'use fatal respects //';
    lives-ok { use fatal; my $x = it-will-fail() || 0; 1 }, 'use fatal respects ||';
    lives-ok { use fatal; my $x = it-will-fail() && 0; 1 }, 'use fatal respects &&';
    lives-ok { use fatal; if it-will-fail() { 1 } else { 0 } }, 'use fatal respects if';
    lives-ok { use fatal; unless it-will-fail() { 1 }; 0 }, 'use fatal respects unless';
    lives-ok { use fatal; it-will-fail() ?? 1 !! 0 }, 'use fatal respects ?? !!';
    lives-ok { use fatal; my $x = ?it-will-fail(); 1 }, 'use fatal respects ?';
    lives-ok { use fatal; my $x = so it-will-fail(); 1 }, 'use fatal respects so';
    lives-ok { use fatal; my $x = !it-will-fail(); 1 }, 'use fatal respects !';
    lives-ok { use fatal; my $x = not it-will-fail(); 1 }, 'use fatal respects not';
    lives-ok { use fatal; my $x = defined it-will-fail(); 1 }, 'use fatal respects defined';
}

# RT #118785
{
    sub fatal-scope(&todo) {
        use fatal;
        todo;
    }

    sub thing-that-fails() {
        fail 'oh noes';
    }

    sub non-fatal-scope {
        thing-that-fails() or 42
    }

    is fatal-scope(&non-fatal-scope), 42, "Fatal scopes are lexical rather than dynamic";
}

# RT #115436
{
    # We now allow more things in Failure.new than when the original RT
    # was filed.
    #
    # Leaving this here in case anyone can figure out some esoteric way to
    # get an X::TypeCheck when Failure.new takes almost any arglist
#    throws-like 'Failure.new("foo").()', X::TypeCheck,
#        "type check for creating Failure object with '.new' (1)";

}

sub s1 {
  sub s2 {
     fail("foo");
  }
  s2();
  CATCH {
      default {
          ok $_.gist ~~ /sub\ss2/,
          "Failure reports backtrace from its creation point."
      }
  }
}
s1();

{
    my $died;
    my $here;
    {
        my $dummy = fail 'oops';
        $here = True;
        CATCH { default { $died = $_ } }
    }
    ok $died ~~ Exception, 'fail outside of routine just behaves like die (1)';
    is ~$died, 'oops', 'fail outside of routine just behaves like die (2)';
    nok $here, 'fail outside of routine just behaves like die (3)';
}

# https://irclog.perlgeek.de/perl6/2016-12-08#i_13706422
throws-like { sink Failure.new }, Exception,
    'sink statement prefix explodes Failures';

{
    my class X::Meow::Meow is Exception {}
    sub foo { fail X::Meow::Meow.new }
    sub bar { foo() orelse fail $_ }
    sub baz { foo() orelse .&fail  }
    fails-like { bar }, X::Meow::Meow,
        'fail(Failure:D) re-arms handled Failures';
    fails-like { baz }, X::Meow::Meow,
        'Failure:D.&fail re-arms handled Failures';
}

# https://github.com/rakudo/rakudo/commit/0a100825dd
subtest 'Failure.self' => {
    plan 2;
    my class X::Meow is Exception { method message { 'meow' } }.new;
    sub failer { fail X::Meow.new }

    throws-like { $ = failer.self }, X::Meow, 'unhandled exceptions explode';

    so my $f = failer;
    is-deeply $f, $f.self, 'handled exceptions are passed through as is';
}

# vim: ft=perl6

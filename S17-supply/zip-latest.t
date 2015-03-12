use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 12;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        tap_ok $s1.zip-latest($s2),
          [(<2 a>), (<2 b>), (<2 c>), (<3 c>), (<4 c>)],
          'zipping 2 supplies works with "zip-latest"',
          :after-tap( {
              $s1.emit('1');
              $s1.emit('2');
              $s2.emit('a');
              $s2.emit('b');
              $s2.emit('c');
              $s1.emit('3');
              $s1.done();
              $s1.emit('4');
              $s2.done();
          } );
    }

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;
        my $s3 = Supply.new;

        tap_ok Supply.zip-latest($s1, $s2, $s3, :with( &infix:<~> )),
          [<aaa aab abb bbb bcb bcc bcd>],
          'zipping three supplies with ~ works with "zip-latest"',
          :after-tap( {
              $s1.emit("ignored");
              $s1.emit("ignored");
              $s2.emit("ignored");
              $s1.emit("ignored");
              $s2.emit("a");
              $s1.emit("a");
              $s3.emit("a");
              $s3.emit("b");
              $s2.emit("b");
              $s1.emit("b");
              $s1.done();
              $s2.emit("c");
              $s3.emit("c");
              $s2.done();
              $s3.emit("d");
              $s3.done();
          } );
    }

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;
        my $s3 = Supply.new;

        tap_ok Supply.zip-latest($s1, $s2, $s3, :with(&infix:<~>), :initial(<x y z>)),
          [<xaz aaz aaa aab abb bbb bcb bcc bcd>],
          'zipping three supplies works with "zip-latest"',
          :after-tap( {
              $s2.emit("a");
              $s1.emit("a");
              $s3.emit("a");
              $s3.emit("b");
              $s2.emit("b");
              $s1.emit("b");
              $s1.done();
              $s2.emit("c");
              $s3.emit("c");
              $s2.done();
              $s3.emit("d");
              $s3.done();
          } );
    }

    {
        my $s = Supply.from-list(1..10);
        my $z = Supply.zip-latest($s);
        ok $s === $z, 'zipping one supply is a noop with "zip-latest"';
        tap_ok $z, [1..10], "noop zip-latest";
    }


    throws_like( { Supply.zip-latest(42) },
      X::Supply::Combinator, combinator => 'zip-latest' );
}

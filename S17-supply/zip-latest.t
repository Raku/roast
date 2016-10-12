use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 13;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;

        tap-ok $s1.Supply.zip-latest($s2.Supply),
          [(<2 a>), (<2 b>), (<2 c>), (<3 c>), (<3 d>)],
          'zipping 2 supplies works with "zip-latest"',
          :after-tap( {
              $s1.emit(val('1'));
              $s1.emit(val('2'));
              $s2.emit('a');
              $s2.emit('b');
              $s2.emit('c');
              $s1.emit(val('3'));
              $s1.done();
              $s2.emit(val('d'));
              $s2.done();
          } );
    }

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;
        my $s3 = Supplier.new;

        tap-ok Supply.zip-latest($s1.Supply, $s2.Supply, $s3.Supply, :with( &infix:<~> )),
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
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;
        my $s3 = Supplier.new;

        tap-ok Supply.zip-latest($s1.Supply, $s2.Supply, $s3.Supply, :with(&infix:<~>), :initial(<x y z>)),
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
        tap-ok $z, [1..10], "noop zip-latest";
    }


    throws-like( { Supply.zip-latest(42) },
      X::Supply::Combinator, combinator => 'zip-latest' );
}

# RT #128694
{
	my $source = Supply.interval(0.5);
	my $heartbeat = Supply.interval(0.3);
	my $s = supply {
		my @collected;
		whenever $source.zip-latest($heartbeat) {
			 @collected.push: 'WHENEVER';
			 if @collected == 10 {
				 emit @collected;
				 done;
			 }
		}
	}
	is await($s.Promise), 'WHENEVER' xx 10, 'No hang when using zip-latest on two intervals';
}

# vim: ft=perl6 expandtab sw=4

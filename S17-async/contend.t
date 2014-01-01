use v6;
use Test;

plan 7;

# simple contend/maybe/defer
sub atomic_sub {
    state $state = 1;
    contend {  ++$state };
    return $state;
}

ok atomic_sub(), 'contend works';
is atomic_sub(), 2, 'contend preserves state';

# try to construct race condition
# see Stevens 'UNIX network programming', 23.17, threads/example01
my $counter = 0;
sub doit {
    my $val;
    loop (my $i = 0; $i < 500; $i++) {
        $val = $counter; $counter = $val + 1;
    }
    return $counter;
}
my @thr = gather {
    take async { doit(); };
    take async { doit(); };
}
is  +@thr, 2, 'one thousand threads';

for @thr { .join(); }; # all threads back

#?pugs skip 'race condition hits about 50% of the time'
ok $counter < 1000, 'the race condition strikes' or diag($counter);


$counter = 0; # new counter because not all threads should be back

# L<S17/Atomic Code blocks>
# now start making C<sub doit> a atomic function
sub doit_right {
    my $val;
    loop (my $i = 0; $i < 500; $i++) {
        contend { $val = $counter; $counter = $val + 1; };
    }
    return $counter;
}

# now raising counter using the protected contend block
my @atomic_thr = gather {
    take async { doit_right(); };
    take async { doit_right(); };
}
for @atomic_thr { .join(); }; # bring them home

is $counter, 1000, 'now we reach the end';

my @cache = ();
#  STM tests on arrays
#?pugs todo 'unimpl'
ok EVAL( q{
    contend { @cache.push( 42 ) };
} ),'method <contend> for arrays; <push> should be safe';

my %cache = ();
#  STM tests on hahses
#?pugs todo 'unimpl'
ok EVAL( q{
    contend { %cache{ 42 } == 1 };
} ),'method <contend> for hashes; insert should be safe';

=begin comment

Copied as a reminder for me from the IRC log.

http://irclog.perlgeek.de/perl6/2008-02-09
 
01:42
	TimToady
	mugwump: mostly we won't be using async {...} or locks, I hope

01:43
	TimToady
	most of the threading will be done by gather/take, lazy lists, and ==> operators
	and most of the (non)-locking will be handled by STM

=end comment

# vim: ft=perl6

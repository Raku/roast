use v6;
use Test;
plan 20;

#?rakudo.parrot skip 'no implementation of supply'
{
    my $measurements = Supply.new;

    my $measured = 0;
    sub measure_ok($test) {
	++$measured;
	pass $test;
    }

    $measurements.tap(-> $value {
	measure_ok("Measured: $value");
    });

    $measurements.more(1.5);
    $measurements.more(2.3);
    $measurements.more(4.6);
    is $measured, 3, 'supply - singular tap';

    $measured = 0;
    $measurements.tap(-> $value {
	measure_ok  "Also measured: $value";
    });

    $measurements.more(2.8);

    is $measured, 2, 'supply dual tap';

    $measurements.grep(* > 4).tap(-> $value {
	measure_ok "HIGH: $value";
    });

    $measured = 0;
    $measurements.more(1.6);
    is $measured, 2, 'supply grep and tap';

    $measured = 0;
    $measurements.more(4.5);
    is $measured, 3, 'supply grep and tap';
}

#?rakudo.parrot skip 'no implementation of supply'
#?rakudo.moar skip 'Supply.interval on moar'
{
    my $n_batches = 0;
    my $batches_intact = True;

    my $belt_raw = Supply.interval(.1).map({ rand xx 20 });
    my $belt_avg = $belt_raw.map(sub (@values) {
	$n_batches++;
	$batches_intact = False
	    unless @values == 20;
	([+] @values) / @values
    });

    my $belt_labeled = $belt_avg.map({ Belt => $_ });
    my $samples = Supply.interval(.5).map({ rand });
    my $samples_labeled = $samples.map({ Sample =>  $_});
    my $merged = $belt_labeled.merge($samples_labeled);

    my $belts_seen = 0;
    my $samples_seen = 0;
    my $out_ok = True;
    my $all_numeric = True;

    my %seen;

    $merged.tap({ 
	%seen{$_.key}{$_.value}++;
	$all_numeric = False
	    unless $_.value.isa('Num');
    });
    sleep 5;

    $belt_raw.done;
    $samples.done;

    ok $n_batches, '@values';
    ok $batches_intact, '@values';
    is_deeply %seen.keys.sort, qw<Belt Sample>, 'merge results';
    ok $all_numeric, 'merge results';
    ok %seen<Sample>.elems >= 3, 'multiple samples';
    ok %seen<Belt>.elems >= %seen<Sample>.elems, 'more belts than samples';
}



use v6;
use Test;
plan 10;

#?rakudo.parrot skip 'no implementation of supply'
{
    my $measurements = Supply.new;

    my %measured;
    sub measure($test, $value) {
	push %measured{$test}, $value;
    }

    $measurements.tap(-> $value {
	measure "Measured", $value;
    });

    $measurements.more(1.5);
    $measurements.more(2.3);
    $measurements.more(4.6);
    is_deeply %measured, {"Measured" => [1.5, 2.3, 4.6]}, 'supply - singular tap';

    %measured = ();
    $measurements.tap(-> $value {
	measure "Also measured", $value;
    });

    $measurements.more(2.8);

    is_deeply %measured, {"Measured" => [2.8], "Also measured" => [2.8]}, 'supply dual tap';

    $measurements.grep(* > 4).tap(-> $value {
	measure "HIGH", $value;
    });

    %measured = ();
    $measurements.more(1.6);
    is_deeply %measured, {"Measured" => [1.6], "Also measured" => [1.6]}, 'supply grep and tap';

    %measured = ();
    $measurements.more(4.5);
    is_deeply %measured, {"Measured" => [4.5], "Also measured" => [4.5], "HIGH" => [4.5]}, 'supply grep and tap';
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

    my $all_numeric = True;
    my %seen;

    $merged.tap({ 
	%seen{.key}{.value}++;
	$all_numeric = False
	    unless .value.isa('Num');
    });
    sleep 5;

    $belt_raw.done;
    $samples.done;

    ok $n_batches, '@values';
    ok $batches_intact, '@values';
    is_deeply %seen.keys.sort, qw<Belt Sample>, 'merge results';
    ok $all_numeric, 'merge results';
    ok +%seen<Sample> >= 3, 'multiple samples';
    ok +%seen<Belt> >= +%seen<Sample>, 'more belts than samples';
}



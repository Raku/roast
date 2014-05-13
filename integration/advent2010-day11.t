# http://perl6advent.wordpress.com/2010/12/11/day-11-markov-sequence/
use v6;
use Test;
plan 2;

#use List::Utils;
#++ copied verbatim from List::Utils;
sub push-one-take-if-enough(@values is rw, $new-value, $n) {
    @values.push($new-value);
    @values.shift if +@values > $n;
    if +@values == $n {
        for @values { take $_ }
    }
}

sub sliding-window(@a, $n) is export {
    my @values;
    gather for @a -> $a {
        push-one-take-if-enough(@values, $a, $n);
    }
}
#--
 
my $model-text = q
<To sleep, perchance to Dream; Aye, there's the rub,
For in that sleep of death, what dreams may come,
When we have shuffled off this mortal coil,
Must give us pause. There's the respect
That makes Calamity of so long life.
>.lc;

$model-text .=subst(/<[_']>/, "", :global);
$model-text .=subst(/<-alpha>+/, " ", :global);

is $model-text.substr(0,9), 'to sleep ', 'text munging';

my %next-step;
for sliding-window($model-text.comb, 3) -> $a, $b, $c {
    %next-step{$a ~ $b}{$c}++;
}

my $first = $model-text.substr(0, 1);
my $second = $model-text.substr(1, 1);
my @chain := $first, $second, -> $a, $b { my $r = %next-step{$a ~ $b}.roll.key } ... *;
my @result = @chain.munch(80);
ok @result > 2, 'got result';
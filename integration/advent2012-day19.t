# http://perl6advent.wordpress.com/2012/12/18/day-18-formulas-resistance-is-futile/

use v6;
use Test;

plan 10;

# Symbol k: return a modified value

sub postfix:<k> ($a) is tighter(&infix:<*>) { $a * 1000 }

is 4.7k, 4.7 * 1000, 'postfix (k)';

# Symbols %: return a closure

sub postfix:<%> ($a) is tighter(&infix:<*>) { * * $a / 100 }
my $f = 5%;
is $f(42), 2.1, 'percentage closure';
is 5%(42), 2.1, 'percentage closure';
is 5 % 42, 5, 'modulo unbusted';

# Symbol Ω: create a new Measure object

enum Unit <volt ampere ohm>;

class Measure {
    has Unit $.unit;
    has $.value;

    method ACCEPTS (Measure:D $a) {
        $!unit == $a.unit && $!value.ACCEPTS($a.value);
    }
}

sub postfix:<V> (Real:D $a) is looser(&postfix:<k>) {
    Measure.new(value => $a, unit => volt)
}
sub postfix:<A> (Real:D $a) is looser(&postfix:<k>) {
    Measure.new(value => $a, unit => ampere)
}
sub postfix:<Ω> (Real:D $a) is looser(&postfix:<k>) {
     Measure.new(value => $a, unit => ohm)
}

is_deeply 4kΩ ~~ 4.0kΩ, True, '~~ / ACCEPTS';
is_deeply 4kΩ ~~ 4.0kV, False, '~~ / ACCEPTS';

# Symbol ±: create a Range object

multi sub infix:<±> (Measure:D $a, Measure:D $b) is looser(&postfix:<Ω>) {
    die if $a.unit != $b.unit;
    Measure.new(value => Range.new($a.value - $b.value,
                                   $a.value + $b.value),
                unit => $a.unit);
}

multi sub infix:<±> (Measure:D $a, Callable:D $b) is looser(&postfix:<Ω>) {
    Measure.new(value => Range.new($a.value - $b($a.value),
                                   $a.value + $b($a.value)),
                unit => $a.unit);
}

is (4.7kΩ ± 1kΩ).gist, Measure.new(unit => Unit::ohm, value => 3700/1..5700/1).gist, 'range object';
is (4.7kΩ ± 5%).gist, Measure.new(unit => Unit::ohm, value => 4465/1..4935/1).gist, 'range object';

my $resistance = 4321Ω;
dies_ok {die "resistance is futile" if !($resistance ~~ 4.7kΩ ± 5%)}, 'reistance is futile';

# Symbols that aren’t operators

constant φ = (1 + sqrt(5)) / 2;

is φ, (1 + sqrt(5)) / 2, 'read-only term';

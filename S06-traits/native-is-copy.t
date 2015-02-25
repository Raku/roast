use v6;
use Test;

# L<S06/"Parameter traits"/"=item is copy">

plan 15;

sub int-is-copy(int $x is copy) {
    is $x, 41, 'Passed value to native int is copy param received';
    $x = 42;
    is $x, 42, 'Can modify passed value to native int is copy param';
}
my $i = 41;
int-is-copy($i);
is $i, 41, 'Variable passed to native int is copy is not modified';

sub num-is-copy(num $x is copy) {
    is $x, 4.1e0, 'Passed value to native num is copy param received';
    $x = 4.2e0;
    is $x, 4.2e0, 'Can modify passed value to native num is copy param';
}
my $n = 4.1e0;
num-is-copy($n);
is $n, 4.1e0, 'Variable passed to native num is copy is not modified';

sub str-is-copy(str $x is copy) {
    is $x, 'borsch', 'Passed value to native str is copy param received';
    $x = 'vindaloo';
    is $x, 'vindaloo', 'Can modify passed value to native str is copy param';
}
my $s = 'borsch';
str-is-copy($s);
is $s, 'borsch', 'Variable passed to native str is copy is not modified';

dies_ok { EVAL 'int-is-copy(4.1e0)' }, 'Cannot pass num to native int is copy arg';
dies_ok { EVAL 'int-is-copy("borsch")' }, 'Cannot pass str to native int is copy arg';
dies_ok { EVAL 'num-is-copy(41)' }, 'Cannot pass int to native num is copy arg';
dies_ok { EVAL 'num-is-copy("borsch")' }, 'Cannot pass str to native num is copy arg';
dies_ok { EVAL 'str-is-copy(41)' }, 'Cannot pass int to native str is copy arg';
dies_ok { EVAL 'str-is-copy(4.1e0)' }, 'Cannot pass num to native str is copy arg';

# vim: ft=perl6

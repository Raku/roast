use v6;
use Test;

plan 5;

# L<S06/Pairs as lvalues/>

eval-dies-ok 'my $var; (key => $var) = "value"';

#?rakudo.moar todo "NYI RT #124660"
#?rakudo.jvm skip "Flattening named argument must have VMHash REPR RT #124661"
{
    my ($a, $b);
    $b = 'b';
    :(:$a) := $b;
    is $a, 'b', 'can bind to single pair';
    ok $a =:= $b, 'variables are bound together (?)';
}

{
    my ($t, $m);
    try :(:type($t), :motivation($m)) := (type => 'geek', motivation => '-Ofun');
    is $t, 'geek',  'bound to the first pair';
    is $m, '-Ofun', 'bound to the second pair';
}




# vim: ft=perl6

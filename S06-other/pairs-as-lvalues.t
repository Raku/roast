use v6;
use Test;

plan 5;

# L<S06/Pairs as lvalues/>

eval_dies_ok 'my $var; (key => $var) = "value"';

{
    my ($a, $b);
    $b = 'b';
    :(:$a) := $b;
    #?rakudo 2 todo "NYI"
    is $a, 'b', 'can bind to single pair';
    ok $a =:= $b, 'variables are bound together (?)';
}

{
    my ($t, $m);
    :(:type($t), :motivation($m)) := (type => 'geek', motivation => '-Ofun');
    is $t, 'geek',  'bound to the first pair';
    is $m, '-Ofun', 'bound ot the second pair';
}




# vim: ft=perl6

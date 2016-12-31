use v6;
use Test;

plan 5;

# L<S06/Pairs as lvalues/>

#?rakudo.jvm todo 'got X::Method::NotFound, RT #130470'
throws-like 'my $var; (key => $var) = "value"', X::Assignment::RO;

#?rakudo todo "NYI RT #124660"
{
    my ($a, $b);
    $b = 'b';
    :(:$a) := $b;
    is $a, 'b', 'can bind to single pair';
    ok $a =:= $b, 'variables are bound together (?)';
}

{
    my ($t, $m);
    :(:type($t), :motivation($m)) := (type => 'geek', motivation => '-Ofun');
    is $t, 'geek',  'bound to the first pair';
    is $m, '-Ofun', 'bound to the second pair';
}




# vim: ft=perl6

use v6;
use Test;
plan 4;

my $a;
nok $a.VAR.dynamic, 'Variables default to not being dynamically scoped';

subtest 'Pragma dynamic-scope without args' => {
    use dynamic-scope;
    my $b;
    ok $b.VAR.dynamic, 'Works on normal variable declarations';
    my ($c, $d);
    ok $c.VAR.dynamic, 'Works on variables declared in list form (1)';
    ok $d.VAR.dynamic, 'Works on variables declared in list form (2)';
}

my $x;
nok $x.VAR.dynamic, 'The dynamic-scope pragma works lexically';

subtest 'Pragma dynamic-scope with args' => {
    use dynamic-scope <$e $g>;
    my $e;
    ok $e.VAR.dynamic, 'Works on normal variable declarations with matching name';
    my $f;
    nok $f.VAR.dynamic, 'Does not make variables without matching name dynamic';
    my ($g, $h);
    ok $g.VAR.dynamic, 'Works on variables declared in list form (1)';
    nok $h.VAR.dynamic, 'Works on variables declared in list form (2)';
}

# vim: expandtab shiftwidth=4

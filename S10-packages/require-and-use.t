use v6;

# L<S11/Runtime Importation>
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 1;

# RT #126688
subtest 'circular dependencies are detected and reported' => {
    plan 2;

    my $dir = make-temp-dir;
    $dir.add('A.pm6').spurt: 'unit class A; use B';
    $dir.add('B.pm6').spurt: 'unit class B; use A';

    is_run ｢use A｣, :compiler-args['-I', $dir.absolute ],
        { :out(''), :err(/:i «circular»/), :status(*.so) },
    "`use` $_" for 'first run', 'second run (precompiled)';
}

# vim: ft=perl6

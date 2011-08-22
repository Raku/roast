use v6;
use Test;
plan 43;

=begin pod

Basic tests of mathematical functions on Cool

=end pod

my $magic = Complex.new(1.1, 2.1);

class NotComplex is Cool {
    method Numeric() {
        $magic;
    }
}

is "-17".abs, 17, '"-17".abs == 17';
is NotComplex.new.abs, $magic.abs, 'NotComplex.new.abs == $magic.abs';

is "3".conjugate, 3, '"3".conjugate == 3';
is NotComplex.new.conjugate, $magic.conjugate, 'NotComplex.new.conjugate == $magic.conjugate';

is_approx "3".exp, 3.exp, '"3".exp == 3.exp';
is_approx NotComplex.new.exp, $magic.exp, 'NotComplex.new.exp == $magic.exp';
is_approx "3".exp("2"), 3.exp(2), '"3".exp("2") == 3.exp(2)';
is_approx NotComplex.new.exp("2"), $magic.exp("2"), 'NotComplex.new.exp("2") == $magic.exp("2")';
is_approx "3".exp(NotComplex.new), 3.exp($magic), '"3".exp(NotComplex.new) == 3.exp($magic)';
is_approx NotComplex.new.exp(NotComplex.new), $magic.exp($magic), 'NotComplex.new.exp(NotComplex.new) == $magic.exp($magic)';

is_approx "17".log, 17.log, '"17".log == 17.log';
is_approx NotComplex.new.log, $magic.log, 'NotComplex.new.log == $magic.log';
is_approx "17".log("17"), 17.log(17), '"17".log("17") == 17.log(17)';
is_approx NotComplex.new.log("17"), $magic.log(17), 'NotComplex.new.log("17") == $magic.log(17)';
is_approx "17".log(NotComplex.new), 17.log($magic), '"17".log("17") == 17.log(17)';
is_approx NotComplex.new.log(NotComplex.new), $magic.log($magic), 'NotComplex.new.log(NotComplex.new) == $magic.log($magic)';

is_approx "17".log10, 17.log10, '"17".log10 == 17.log10';
is_approx NotComplex.new.log10, $magic.log10, 'NotComplex.new.log10 == $magic.log10';

is_approx "17".sqrt, 17.sqrt, '"17".sqrt == 17.sqrt';
is_approx NotComplex.new.sqrt, $magic.sqrt, 'NotComplex.new.sqrt == $magic.sqrt';

{
    my @found-roots = "17".roots("4");
    my @ideal-roots = 17.roots(4);
    
    for @ideal-roots -> $i {
        is @found-roots.grep({ ($i - $_).abs < 1e-6 }).elems, 1, "root $i found once";
    }

    @found-roots = NotComplex.new.roots("3");
    @ideal-roots = $magic.roots(3);
    
    for @ideal-roots -> $i {
        is @found-roots.grep({ ($i - $_).abs < 1e-6 }).elems, 1, "root $i found once";
    }
}

is_approx "17"i, 17i, '"17"i == 17i';
is_approx (NotComplex.new)i, $magic\i, '(NotComplex.new)i == $magic\i';

#?rakudo 4 skip 'angle conversion'
is_approx "17".to-radians(Degrees), 17.to-radians(Degrees),
          '"17".to-radians(Degrees) == 17.to-radians(Degrees)';
is_approx NotComplex.new.to-radians(Gradians), $magic.to-radians(Gradians),
          'NotComplex.new.to-radians(Gradians) == $magic.to-radians(Gradians)';

is_approx "17".from-radians(Degrees), 17.from-radians(Degrees),
          '"17".from-radians(Degrees) == 17.from-radians(Degrees)';
is_approx NotComplex.new.from-radians(Gradians), $magic.from-radians(Gradians),
          'NotComplex.new.from-radians(Gradians) == $magic.from-radians(Gradians)';

is_approx "17.25".floor, 17.25.floor, '"17.25".floar == 17.25.floor';
is_approx "17.25".ceiling, 17.25.ceiling, '"17.25".floar == 17.25.ceiling';
#?rakudo 2 skip 'round'
is_approx "17.25".round, 17.25.round, '"17.25".floar == 17.25.round';
is_approx "17.25".round("0.1"), 17.25.round(0.1), '"17.25".floar("0.1") == 17.25.round(0.1)';
is_approx "17.25".truncate, 17.25.truncate, '"17.25".floar == 17.25.truncate';

is "17".sign, 1, '"17".sign == 1';
is "-17".sign, -1, '"-17".sign == -1';
is "0".sign, 0, '"0".sign == 0';

is_approx "17".cis, 17.cis, '"17".cis == 17.cis';
is_approx "17".unpolar("42"), 17.unpolar(42), '"17".unpolar("42") == 17.unpolar(42)';

done;

# vim: ft=perl6

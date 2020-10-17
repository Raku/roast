use v6;
use Test;
plan 46;

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

is "3".conj, 3, '"3".conj == 3';
is NotComplex.new.conj, $magic.conj, 'NotComplex.new.conj == $magic.conj';

is-approx "3".exp, 3.exp, '"3".exp == 3.exp';
is-approx NotComplex.new.exp, $magic.exp, 'NotComplex.new.exp == $magic.exp';
is-approx "3".exp("2"), 3.exp(2), '"3".exp("2") == 3.exp(2)';
is-approx NotComplex.new.exp("2"), $magic.exp("2"), 'NotComplex.new.exp("2") == $magic.exp("2")';
is-approx "3".exp(NotComplex.new), 3.exp($magic), '"3".exp(NotComplex.new) == 3.exp($magic)';
is-approx NotComplex.new.exp(NotComplex.new), $magic.exp($magic), 'NotComplex.new.exp(NotComplex.new) == $magic.exp($magic)';

is-approx "17".log, 17.log, '"17".log == 17.log';
is-approx NotComplex.new.log, $magic.log, 'NotComplex.new.log == $magic.log';
is-approx "17".log("17"), 17.log(17), '"17".log("17") == 17.log(17)';
is-approx NotComplex.new.log("17"), $magic.log(17), 'NotComplex.new.log("17") == $magic.log(17)';
is-approx "17".log(NotComplex.new), 17.log($magic), '"17".log("17") == 17.log(17)';
is-approx NotComplex.new.log(NotComplex.new), $magic.log($magic), 'NotComplex.new.log(NotComplex.new) == $magic.log($magic)';

is-approx "17".log10, 17.log10, '"17".log10 == 17.log10';
is-approx NotComplex.new.log10, $magic.log10, 'NotComplex.new.log10 == $magic.log10';

is-approx "17".sqrt, 17.sqrt, '"17".sqrt == 17.sqrt';
is-approx NotComplex.new.sqrt, $magic.sqrt, 'NotComplex.new.sqrt == $magic.sqrt';

#?DOES 8
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

#?DOES 2
{
is-approx "17"i, 17i, '"17"i == 17i';
is-approx (NotComplex.new)i, $magic\i, '(NotComplex.new)i == $magic\i';
}

#?rakudo skip 'angle conversion'
#?DOES 4
{
is-approx "17".to-radians(Degrees), 17.to-radians(Degrees),
          '"17".to-radians(Degrees) == 17.to-radians(Degrees)';
is-approx NotComplex.new.to-radians(Gradians), $magic.to-radians(Gradians),
          'NotComplex.new.to-radians(Gradians) == $magic.to-radians(Gradians)';

is-approx "17".from-radians(Degrees), 17.from-radians(Degrees),
          '"17".from-radians(Degrees) == 17.from-radians(Degrees)';
is-approx NotComplex.new.from-radians(Gradians), $magic.from-radians(Gradians),
          'NotComplex.new.from-radians(Gradians) == $magic.from-radians(Gradians)';
}

is-approx "17.25".floor, 17.25.floor, '"17.25".floor == 17.25.floor';
is-approx "17.25".ceiling, 17.25.ceiling, '"17.25".ceiling == 17.25.ceiling';
is-approx "17.25".round, 17.25.round, '"17.25".round == 17.25.round';
is-approx "17.25".round("0.1"), 17.25.round(0.1), '"17.25".round("0.1") == 17.25.round(0.1)';
is-approx "17.25".truncate, 17.25.truncate, '"17.25".truncate == 17.25.truncate';

is "17".sign, 1, '"17".sign == 1';
is "-17".sign, -1, '"-17".sign == -1';
is "0".sign, 0, '"0".sign == 0';

is-approx "17".cis,   17.cis, '"17".cis == 17.cis';
is-approx <4+2i>.cis, <-0.0884610445653817-0.102422080056674i>, '<4+2i>.cis';
is-approx i.cis,      <0.367879441171442+0i>,                   'i.cis';

is-approx "17".unpolar("42"), 17.unpolar(42), '"17".unpolar("42") == 17.unpolar(42)';

subtest 'truncate() with Cools' => {
    plan 15;
    my @array = ["a", 1, "b", 2];
    is-deeply truncate(@array), @array.elems, 'truncate(Array)';
    is-deeply truncate(True), True, 'truncate(Bool::True)';
    is-deeply truncate(False), False, 'truncate(Bool::False)';
    # Complex tested in S32-num/complex.t
    class Cooler is Cool {
        method Numeric(--> 5) {}
    }
    is-deeply truncate(Cooler.new), 5, 'truncate(Cool)';
    is-deeply truncate(Duration.new(4)), 4, 'truncate(Duration)';
    my %map is Map = "a", 1, "b", 2;
    is-deeply truncate(%map), %map.elems, 'truncate(Map)';
    is-deeply truncate(FatRat.new(2**67, 2**66 + 1)), 1, 'truncate(FatRat)';
    my %hash = "a", 1, "b", 2;
    is-deeply truncate(%hash), %hash.elems, 'truncate(Hash)';
    my $instant = now;
    is-deeply truncate($instant), $instant.Int, 'truncate(Instant)';
    # Int is tested in S32-num/int.t
    my @list := "a", 1, "b", 2;
    is-deeply truncate(@list), @list.elems, 'truncate(List)';
    my $number = 123.45;
    my $match = "abc $number def" ~~ /\d+/;
    is-deeply truncate($match), truncate($number), 'truncate(Match)';
    is-deeply truncate(200.3e-2), 2, 'truncate(Num)';
    my $range = ^5;
    is-deeply truncate($range), $range.elems, 'truncate(Range)';
    my $seq = (1 ... 7);
    is-deeply truncate($seq), $seq.elems, 'truncate(Seq)';
    class Stasher is Stash {
        class Counted { };
        my class NotCounted { };
        our sub counted { };
        my sub notcounted { };
        method notcountedeither { };
    }
    is-deeply truncate(Stasher::), Stasher::.elems, 'truncate(Stash)';
    # Str is tested above
}

# vim: expandtab shiftwidth=4

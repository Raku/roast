use v6.c;
# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use Test;

sub degrees-to-radians($x) {
    $x * (312689/99532) / 180;
}

my @sines = (
    degrees-to-radians(-360) => 0,
    degrees-to-radians(135 - 360) => 1/2*sqrt(2),
    degrees-to-radians(330 - 360) => -0.5,
    degrees-to-radians(0) => 0,
    degrees-to-radians(30) => 0.5,
    degrees-to-radians(45) => 1/2*sqrt(2),
    degrees-to-radians(90) => 1,
    degrees-to-radians(135) => 1/2*sqrt(2),
    degrees-to-radians(180) => 0,
    degrees-to-radians(225) => -1/2*sqrt(2),
    degrees-to-radians(270) => -1,
    degrees-to-radians(315) => -1/2*sqrt(2),
    degrees-to-radians(360) => 0,
    degrees-to-radians(30 + 360) => 0.5,
    degrees-to-radians(225 + 360) => -1/2*sqrt(2),
    degrees-to-radians(720) => 0
);

my @cosines = @sines.map({; $_.key - degrees-to-radians(90) => $_.value }); #OK

my @sinhes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @coshes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) + exp(-$_.key)) / 2.0 });

class NotComplex is Cool {
    has $.value;

    multi method new(Complex $value is copy) {
        self.bless(:$value);
    }

    multi method Numeric() {
        self.value;
    }
}

class DifferentReal is Real {
    has $.value;

    multi method new($value is copy) {
        self.bless(:$value);
    }

    multi method Bridge() {
        self.value.Num;
    }
}            



# cosech tests

for @sines -> $angle
{
    next if abs(sinh($angle.key())) < 1e-6;
    my $desired-result = 1.0 / sinh($angle.key());

    # Num.cosech tests -- very thorough
    is-approx($angle.key().cosech, $desired-result, 
              "Num.cosech - {$angle.key()}");

    # Complex.cosech tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { 1.0 / sinh($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { 1.0 / sinh($_) }($zp2);
    
    is-approx($zp0.cosech, $sz0, "Complex.cosech - $zp0");
    is-approx($zp1.cosech, $sz1, "Complex.cosech - $zp1");
    is-approx($zp2.cosech, $sz2, "Complex.cosech - $zp2");
}

#?niecza skip "Inf results wrong"
{
    is(cosech(Inf), 0, "cosech(Inf) -");
    is(cosech(-Inf), "-0", "cosech(-Inf) -");
}
        
{
    # Num tests
    is-approx(cosech((-6.283185).Num), -0.00373489848806798, "cosech(Num) - -6.283185");
}

{
    # Rat tests
    is-approx((-3.9269908).Rat(1e-9).cosech, -0.0394210493494572, "Rat.cosech - -3.9269908");
    is-approx(cosech((-0.5235988).Rat(1e-9)), -1.8253055746695, "cosech(Rat) - -0.5235988");
}

{
    # Complex tests
    is-approx(cosech((0.523598775603156+2i).Complex), -0.202302149262384-0.920006877922264i, "cosech(Complex) - 0.523598775603156+2i");
}

{
    # Str tests
    is-approx((0.7853982).Str.cosech, 1.15118387090806, "Str.cosech - 0.7853982");
    is-approx(cosech((1.5707963).Str), 0.434537208087792, "cosech(Str) - 1.5707963");
}

{
    # NotComplex tests
    is-approx(NotComplex.new(2.3561944902142+2i).cosech, -0.0772627459225851-0.171882832059526i, "NotComplex.cosech - 2.3561944902142+2i");
    is-approx(cosech(NotComplex.new(3.14159265361894+2i)), -0.0358119530230833-0.078543348553443i, "cosech(NotComplex) - 3.14159265361894+2i");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(3.9269908).cosech, 0.0394210493494572, "DifferentReal.cosech - 3.9269908");
    is-approx(cosech(DifferentReal.new(4.7123890)), 0.0179680320529917, "cosech(DifferentReal) - 4.7123890");
}

{
    # FatRat tests
    is-approx((5.4977871).FatRat.cosech, 0.00819178720191627, "FatRat.cosech - 5.4977871");
    is-approx(cosech((6.283185).FatRat), 0.00373489848806798, "cosech(FatRat) - 6.283185");
}


# acosech tests

for @sines -> $angle
{
    next if abs(sinh($angle.key())) < 1e-6;
    my $desired-result = 1.0 / sinh($angle.key());

    # Num.acosech tests -- thorough
    is-approx($desired-result.Num.acosech.cosech, $desired-result, 
              "Num.acosech - {$angle.key()}");
    
    # Num.acosech(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is-approx($z.acosech.cosech, $z, 
                  "Complex.acosech - $z");
    }
}
        
{
    # Num tests
    is-approx(acosech((1.8253055746695).Num), 0.5235988, "acosech(Num) - 0.5235988");
}

{
    # Rat tests
    is-approx(((1.15118387090806).Rat(1e-9)).acosech, 0.7853982, "Rat.acosech - 0.7853982");
    is-approx(acosech((1.8253055746695).Rat(1e-9)), 0.5235988, "acosech(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(acosech((0.785398163404734+2i).Complex), 0.186914543518615-0.439776333846415i, "acosech(Complex) - 0.186914543518615-0.439776333846415i");
}

{
    # Str tests
    is-approx(((1.8253055746695).Str).acosech, 0.5235988, "Str.acosech - 0.5235988");
    is-approx(acosech((1.15118387090806).Str), 0.7853982, "acosech(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((NotComplex.new(0.523598775603156+2i)).acosech, 0.137815559024863-0.481963452541975i, "NotComplex.acosech - 0.137815559024863-0.481963452541975i");
    is-approx(acosech(NotComplex.new(0.785398163404734+2i)), 0.186914543518615-0.439776333846415i, "acosech(NotComplex) - 0.186914543518615-0.439776333846415i");
}

{
    # DifferentReal tests
    is-approx((DifferentReal.new(1.8253055746695)).acosech, 0.5235988, "DifferentReal.acosech - 0.5235988");
    is-approx(acosech(DifferentReal.new(1.15118387090806)), 0.7853982, "acosech(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((1.8253055746695).FatRat).acosech, 0.5235988, "FatRat.acosech - 0.5235988");
    is-approx(acosech((1.15118387090806).FatRat), 0.7853982, "acosech(FatRat) - 0.7853982");
}

done-testing;

# vim: ft=perl6 nomodifiable

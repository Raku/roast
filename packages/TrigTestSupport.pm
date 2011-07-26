use v6;

class AngleAndResult
{
    has $.angle_in_degrees;
    has $.result;

    our @radians-to-whatever = (1, 180 / pi, 200 / pi, 1 / (2 * pi));
    our @degrees-to-whatever = ((312689/99532) / 180, 1, 200 / 180, 1 / 360);
    our @degrees-to-whatever-num = @degrees-to-whatever.map({ .Num });

    multi method new(Int $angle_in_degrees is copy, $result is copy) {
        self.bless(*, :$angle_in_degrees, :$result);
    }

    method complex($imaginary_part_in_radians, $base) {
        my $z_in_radians = $.angle_in_degrees / 180.0 * pi + ($imaginary_part_in_radians)i;
        $z_in_radians * @radians-to-whatever[$base];
    }
    
    method num($base) {
        $.angle_in_degrees * @degrees-to-whatever-num[$base];
    }
    
    method rat($base) {
        $.angle_in_degrees * @degrees-to-whatever[$base];
    }
    
    method int($base) {
        $.angle_in_degrees;
    }
    
    method str($base) {
        ($.angle_in_degrees * @degrees-to-whatever-num[$base]).Str;
    }
}

class TrigTest {
    our sub sines() {
        AngleAndResult.new(-360, 0),
        AngleAndResult.new(135 - 360, 1/2*sqrt(2)),
        AngleAndResult.new(330 - 360, -0.5),
        AngleAndResult.new(0, 0),
        AngleAndResult.new(30, 0.5),
        AngleAndResult.new(45, 1/2*sqrt(2)),
        AngleAndResult.new(90, 1),
        AngleAndResult.new(135, 1/2*sqrt(2)),
        AngleAndResult.new(180, 0),
        AngleAndResult.new(225, -1/2*sqrt(2)),
        AngleAndResult.new(270, -1),
        AngleAndResult.new(315, -1/2*sqrt(2)),
        AngleAndResult.new(360, 0),
        AngleAndResult.new(30 + 360, 0.5),
        AngleAndResult.new(225 + 360, -1/2*sqrt(2)),
        AngleAndResult.new(720, 0)
    }

    our sub cosines() {
        sines.map({ AngleAndResult.new($_.angle_in_degrees - 90, $_.result) });
    }

    our sub sinhes() {
        sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                                 (exp($_.num(Radians)) - exp(-$_.num(Radians))) / 2.0)});
    }

    our sub coshes() { 
        sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                                 (exp($_.num(Radians)) + exp(-$_.num(Radians))) / 2.0)});
    }

    our sub official_bases() {
        (Radians, Degrees, Gradians, Circles);
    }
}

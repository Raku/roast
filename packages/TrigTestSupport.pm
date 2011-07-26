use v6;

class AngleAndResult
{
    has $.angle_in_degrees;
    has $.angle_in_radians;
    has $.result;

    multi method new(Int $angle_in_degrees, $result is copy) {
        self.bless(*, :$angle_in_degrees, 
                      :angle_in_radians($angle_in_degrees * (312689/99532) / 180), 
                      :$result);
    }

    method num() {
        $.angle_in_radians;
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
                                                 (exp($_.num()) - exp(-$_.num())) / 2.0)});
    }

    our sub coshes() { 
        sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                                 (exp($_.num()) + exp(-$_.num())) / 2.0)});
    }
}

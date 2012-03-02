module Exportops;

sub postfix:<!>(Int $x)      is export(:DEFAULT) { [*] 1..$x }
sub infix:<yadayada>($a, $b) is export(:DEFAULT) { $a ~ ".." ~ $b }

# Unicode stuff
sub prefix:<¢>($a)           is export(:DEFAULT) { "$a cent" }
sub infix:<±>($a, $b)        is export(:DEFAULT) { $a - $b .. $a + $b }

# exported multi

class NotANumber is export {
    has $.number;
}

sub infix:<NAN+>(NotANumber $a, NotANumber $b) is export(:DEFAULT) {
    NotANumber.new(:number($a.number + $b.number));
}

multi sub infix:<+>(NotANumber $a, NotANumber $b) is export(:DEFAULT) {
    NotANumber.new(:number($a.number + $b.number));
}

# not exported operator

sub infix:<notthere>($a, $b) { $a + $b }

# vim: ft=perl6

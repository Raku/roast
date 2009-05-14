module Exportops;

sub postfix:<!>(Int $x)      is export(:DEFAULT) { [*] 1..$x }
sub infix:<yadayada>($a, $b) is export(:DEFAULT) { $a ~ ".." ~ $b }

# Unicode stuff
sub prefix:<¢>($a)           is export(:DEFAULT) { "$a cent" }
sub infix:<±>($a, $b)        is export(:DEFAULT) { $a - $b .. $a + $b }

# not exported operator

sub infix:<notthere>($a, $b) { $a + $b }

# vim: ft=perl6

use v6;
use Test;

plan 4;

#L<S05/Modifiers/"The :c">

regex simple { . a };
my $string = "1a2a3a";

$string ~~ m:c/<simple>/;
is(~$/, '1a', "match first 'a'");
$string ~~ m:c/<simple>/;
is(~$/, '2a', "match second 'a'");
$string ~~ m:c/<simple>/;
is(~$/, '3a', "match third 'a'");
$string ~~ m:c/<simple>/;
is(~$/, '', "no more 'a's to match");

# vim: syn=perl6 sw=4 ts=4 expandtab

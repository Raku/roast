use v6;

use Test;

plan 3;

#not really much of a test (no links to the spec either). Please improve, I only wrote what was required! --lue

sub a () { my $a=4; }; #zero-arg sub to test the underlying problem   #OK not used

eval_dies_ok 'e("wtz")', "e should not be defined to accept arguments";
eval_dies_ok 'pi("wtz")',"pi should not be defined to accept arguments either :) ";
nok eval('a(3)'), "this should die, no arguments defined";

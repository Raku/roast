# http://perl6advent.wordpress.com/2011/12/24/day-24-subs-are-always-better-in-multi-ples/
use v6;
use Test;
plan 7;

multi sub steve(Str $name) {
    return "Hello, $name";
}
 
multi sub steve(Int $number) {
    return "You are person number $number to use this sub!";
}

is steve("John"), "Hello, John", 'multi';
is steve(35), "You are person number 35 to use this sub!", 'multi';

# Advent post is checking a user defined sub against a built in.
# This just tests two user defined subs that have been declared
# at the same level.

my $unambigous = q:to'--END--';
proto sub Slurp(|) { * }
multi sub Slurp($filename) {
    pass "Yum! $filename was tasty. Got another one?";
}
--END--

my $ambigous = $unambigous ~ q:to'--END--';
multi sub Slurp($filename) {
    fail "Yuck! $filename is no good!";
}
--END--

eval_lives_ok $unambigous ~ 'Slurp("README.md")', 'unambigous multi - lives';
eval_dies_ok  $ambigous   ~ 'Slurp("README.md")',  'ambigous multi - dies';

class Present {
    has $.item;
    has $.iswrapped = True;
 
    method look() {
        if $.iswrapped {
            pass "It's wrapped.";
        }
        else {
            say $.item;
        }
    }
 
    method unwrap() {
        $!iswrapped = False;
    }
}

multi sub open(Present $present) {
    $present.unwrap;
    pass "You unwrap the present and find...!";
}

my $gift = Present.new(:item("sock"));
$gift.look;
open($gift);
$gift.look;


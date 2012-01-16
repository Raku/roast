# http://perl6advent.wordpress.com/2009/12/22/day-22-operator-overloading/

use v6;
use Test;

plan 4;

multi sub postfix:<!>(Int $n) {
    [*] 1..$n;
}

is 3!, 6, 'factorial operator';

class PieceOfString {
    has $.length;
}

## This example seems odd. Why is it passing 2 args to :length in the .new call?
multi sub infix:<+>(PieceOfString $lhs, PieceOfString $rhs) {
    PieceOfString.new(:length($lhs.length, $rhs.length));
}

my $a = PieceOfString.new(:length(4));
my $b = PieceOfString.new(:length(6));

my $c = $a + $b;
is $c.length, (4,6), "+ override";

multi sub infix:<==>(PieceOfString $lhs, PieceOfString $rhs --> Bool) {
    $lhs.length == $rhs.length;
}

my $d = PieceOfString.new(:length(6));
#?niecza skip 'No candidates for dispatch to &infix:<==>'
ok $b == $d, "override equality";

# XXX This pragma was NOT used in the advent calendar.
use MONKEY_TYPING;

augment class PieceOfString {
    method Str {
        '-' x $.length;
    }
}

is ~$d, '------', 'Str override';

done;

use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 9;

## If this test file is fudged, then MAIN never executes because
## the fudge script introduces an C<exit(1)> into the mainline.
## This definition prevents that insertion from having any effect.  :-)
sub exit { }

# L<S06/Declaring a C<MAIN> subroutine/>

sub MAIN($a, $b, *@c) {
    ok(1, 'MAIN called correctly');
    is($a, 'a', 'first positional param set correctly');
    is($b, 'b', 'second positional param set correctly');
    is(~@c, 'c d e', 'slurpy param set correctly');
}

@*ARGS = <a b c d e>;

ok( @*ARGS == 5, '@*ARGS has correct elements');

# RT #114354
lives-ok { require HasMain }, 'MAIN in a module did not get executed';

# RT #126029
is_run 'sub MAIN() { map { print "ha" }, ^3 }',
    {
        out => "hahaha",
    },
    'MAIN return value is sunk';


# RT #130131
subtest 'MAIN can take type-constrain using Enums' => {
    plan 3;

    my $code = Q:to/END/;
        enum Hand <Rock Paper Scissors>;
        sub MAIN (Hand $hand, Hand :$pos-hand) {
            print "pass";
        }
    END
    is_run $code, :args[<Rock>                    ], { :out<pass>, :err('') }, 'positional works';
    is_run $code, :args[<--pos-hand=Scissors Rock>], { :out<pass>, :err('') }, 'positional + named works';
    is_run $code, :args[<Hand>                    ], { :out{not .contains: 'pass'}, :err(/'=<Hand>'/) },
        'name of enum itself is not valid and usage message prints the name of the enum';
}

subtest '%*SUB-MAIN-OPTS<named-anywhere>', {
    plan 4;

    is_run ｢
        (my %*SUB-MAIN-OPTS)<named-anywhere> or print "pass"
    ｣, {:out<pass>, :err('')},
    'by default, %*SUB-MAIN-OPTS<named-anywhere> exists and is set to False';

    is_run ｢
        sub MAIN ($a, $b, :$c, :$d) { print "fail" }
        sub USAGE { print "pass" }
    ｣, :args[<1 --c=2 3 --d=4>], {:out<pass>, :err('')},
    'no opts set does not allow named args anywhere';

    is_run ｢
        (my %*SUB-MAIN-OPTS)<named-anywhere> = False;
        sub MAIN ($a, $b, :$c, :$d) { print "fail" }
        sub USAGE { print "pass" }
    ｣, :args[<1 --c=2 3 --d=4>], {:out<pass>, :err('')},
    '<named-anywhere> set to false does not allow named args anywhere';

    is_run ｢
        (my %*SUB-MAIN-OPTS)<named-anywhere> = True;
        sub MAIN ($a, $b, :$c, :$d) { print "pass" }
        sub USAGE { print "fail" }
    ｣, :args[<1 --c=2 3 --d=4>], {:out<pass>, :err(''), :0status},
    '<named-anywhere> set to true allows named args anywhere';
}

# vim: ft=perl6

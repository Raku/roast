use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 8;

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
#?niecza todo
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

# vim: ft=perl6
